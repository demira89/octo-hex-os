/* libc.c : Currently implements the needed C library functions.
 * */

#include "limits.h"
#include "kernel.h"

size_t strlen(const char* str)
{
		register const char* s = str;
		register size_t rv = 0;
		if (!s)
				return 0;
		while (*s++)
				rv++;
		return rv;
}

int strcmp(const char* p1, const char* p2)
{
		register const unsigned char* s1 = (const unsigned char*)p1;
		register const unsigned char* s2 = (const unsigned char*)p2;
		register unsigned char c1, c2;
		
		do {
				c1 = (unsigned char)*s1++;
				c2 = (unsigned char)*s2++;
				if (c1 == '\0')
						return c1 - c2;
		} while (c1 == c2);

		return c1 - c2;
}

int strncmp(const char* p1, const char* p2, size_t num)
{
		register const unsigned char* s1 = (const unsigned char*)p1;
		register const unsigned char* s2 = (const unsigned char*)p2;
		register unsigned char c1, c2;
		register size_t n = num;
		
		while (n) {
				c1 = (unsigned char)*s1++;
				c2 = (unsigned char)*s2++;
				if (c1 == '\0' || (c1 != c2))
						return c1 - c2;
				else
						n--;
		}

		return c1 - c2;
}

char* strstr(const char* p1, const char* p2)
{
		register const unsigned char* s1 = (const unsigned char*)p1;
		register const unsigned char* s2 = (const unsigned char*)p2;
		if (!p1)
				return NULL;
		if (!p2)
				return (char*)p1;
		while (*s1) {
				if (*s1 != *s2) {
						s2 = (const unsigned char*)p2;
						p1 = (const char*)(s1 + 1);
				} else if (!*s2)
						return (char*)p1;
				s1++; s2++;
		}
		return (*s2) ?  NULL : (char*)p1;
}

void bzero(void* ptr, size_t s)
{
		register uint8_t* p = (uint8_t*)ptr;
		if (s >= 8) {
				/* first align to dword boundary */
				while ((size_t)p % 4) {
						*p++ = 0;
						s--;
				}
				/* now clear uint32_t-sized blocks */
				while (s >= 4) {
						*(uint32_t*)p = 0;
						p += 4;
						s -= 4;
				}
		}
		/* set remaining memory */
		while (s--)
				*p++ = 0;
}

void* memmove(void* dest, const void* src, size_t len)
{
		register uint8_t* p = (uint8_t*)dest;
		register uint8_t* s = (uint8_t*)src;
		if (((size_t)__builtin_abs(dest - src)) >= len) { /* FWD copy */
			while (len--)
					*p++ = *s++;
		} else {
				dest += len;
				src += len;
				while (len--)
						*--p = *--s;
		}
		return dest;
}

void* memset(void* ptr, int value, size_t num)
{
		register uint8_t* p = (uint8_t*)ptr;
		while (num--)
				*p++ = (uint8_t)value;
		return ptr;
}

int isspace(int c)
{
		return (c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r');
}

int isprint(int c)
{
		if (c > 0x1f && c < 0x7f)
				return 1;
		return 0;
}

long int strtol(const char* str, char** endptr, int base)
{
		unsigned long int rv = 0, isN = 0;
		char num_max, char_max, char2_max;
		if (!str || base > 32 || base < 0 || base == 1) {
				errno = EINVAL;
				return 0L;
		}
		while (isspace(*str))
				str++;
		if (!base) {
				/* read prefix */
				if (*str == '0') {
						base = 8;
						str++;
						if (*str == 'x' || *str == 'X') {
								base = 16;
								str++;
						}
				} else
						base = 10;
		}
		num_max = ((base >= 10) ? '9' : ('0' + base - 1));
		char_max = ((base <= 10) ? ('A' - 1) : ('A' + base - 11));
		char2_max = ((base <= 10) ? ('a' - 1) : ('a' + base - 11));
		if (*str == '-' || *str == '+')
				isN = (*str++ == '-');
		while (1) {
				uint8_t addv = 0xff;
				if(*str >= '0' && *str <= num_max)
						addv = *str - '0';
				else if (*str >= 'A' && *str <= char_max)
						addv = (*str - 'A') + 10;
				else if (*str >= 'a' && *str <= char2_max)
						addv = (*str - 'a') + 10;

				if (addv == 0xff) {
						if (endptr)
								*endptr = (char*)str;
						if (isN == 2 || isN == 3) {
								errno = ERANGE;
								return isN == 2 ? LONG_MAX : LONG_MIN;
						}
						return isN ? -rv : rv;
				} else {
						if (isN == 0) {
								if (rv * base + addv > LONG_MAX)
										isN = 2;
								else
										rv = rv * base + addv;
						} else {
								if ((rv * base + addv) > (unsigned long int)(LONG_MAX) + 1)
										isN = 3;
								else
										rv = rv * base + addv;
						}
				}
				str++;
		}
}

int atoi(const char* str)
{
		unsigned int rv = 0, isN = 0;
		if (!str)
				return 0;
		while (isspace(*str))
				str++;
		if (*str == '-') {
				isN = 1;
				str++;
		} else if (*str == '+')
				str++;
		while (*str >= '0' && *str <= '9') {
				rv *= 10;
				rv += *str - '0';
				str++;
		}
		if (isN && rv)
				return (int)-rv;
		else
				return (int)rv;

}

char* strchr(const char* str, int character)
{
		if (!str)
				return NULL;
		while (*str != (char)character)
				if (*str == '\0')
						return NULL;
				else
						str++;
		return (char*)str;
}

char* strndup(const char* s, size_t n)
{
		size_t l; char* rv;
		if (!s)
				return NULL;
		l = strlen(s);
		rv = kmalloc(1 + (l = min(l, n)));
		if (!rv) {
				errno = ENOMEM;
				return NULL;
		}
		for (n = 0; n < l; n++)
				rv[n] = s[n];
		rv[n] = '\0';
		return rv;
}

char* strdup(const char* s)
{
		char* rv; size_t l, n;
		if (!s)
				return NULL;
		l = strlen(s) + 1;
		rv = kmalloc(l);
		for (n = 0; n < l; n++)
				rv[n] = s[n];
		rv[n] = '\0';
		return rv;
}

char* strncpy(char* dest, const char* src, size_t n)
{
		size_t i;
		if (!dest)
				return NULL;
		for (i = 0; i < n; i++) {
				dest[i] = src ? *src : '\0';
				if (src && !(*src))
						src = NULL;
				else if (src)
						src++;
		}
		return dest;
}

char* strcpy(char* dest, char* src)
{
		char* rv = dest;
		if (!dest || !src)
				return NULL;
		do {
			*(dest++) = *(src++);
		} while (*src);
		return rv;
}

char* strtok_r(char* str, const char* delim, char** saveptr)
{
		size_t l = strlen(delim);
		if (str)
				*saveptr = str;
		str = *saveptr;
		if (!l) { /* return full token only once */
				*saveptr = NULL;
				return str;
		}
		while (*str) {
				for (size_t i = 0; i < l; i++)
						if (*str == delim[i]) {
								*str = '\0';
								if (strlen(*saveptr)) {
										char* rv = *saveptr;
										*saveptr = str + 1;
										return rv;
								} else
										*saveptr = str + 1;
								break;
						}
				str++;
		}
		/* in case of no delims return full token once */
		if (str == *saveptr)
				return NULL;
		else {
				char* rv = *saveptr;
				*saveptr = str;
				return rv;
		}
}

char* strtok(char* str, const char* delim)
{
		static char* ptr;
		return strtok_r(str, delim, &ptr);
}

char* asctime_r(const struct tm* timep, char* result)
{
		static char wday_name[7][3] = {
			"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
		};
		static char mon_name[12][3] = {
			"Jan", "Feb", "Mar", "Apr", "May", "Jun",
			"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
		};
		char zerobt = 0;

		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
			wday_name[timep->tm_wday],
			mon_name[timep->tm_mon],
			timep->tm_mday, timep->tm_hour,
			timep->tm_min, timep->tm_sec,
			1900 + timep->tm_year);
		return result;
}

char* asctime(const struct tm* timep)
{
		static char result[26];
		return asctime_r(timep, result);
}

char* ctime(const time_t* timep)
{
		return asctime(localtime(timep));
}

char* ctime_r(const time_t* timep, char* result)
{
		return asctime_r(localtime(timep), result);
}

time_t time(time_t* timep)
{
}

time_t mktime(struct tm* timep)
{
}

#define COUNT_LEAPS(Y)   ( ((Y)-1)/4 - ((Y)-1)/100 + ((Y)-1)/400 )
#define COUNT_DAYS(Y)  ( ((Y)-1)*365 + COUNT_LEAPS(Y) )
#define IS_LEAP_YEAR(Y)     ( ((Y)>0) && !((Y)%4) && ( ((Y)%100) || !((Y)%400) ) )
struct tm* gmtime_r(const time_t* timep, struct tm* result)
{
		int dayct = *timep / 86400, isl, rem;
		*result = (struct tm){0};
		result->tm_wday = (dayct + 4) % 7; /* Jan 1 1970 is Thu */
		while (COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970) <= dayct)
			result->tm_year++;
		result->tm_year--;
		isl = IS_LEAP_YEAR(result->tm_year);
		dayct -= COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970);
		result->tm_yday = dayct;
		static const int dayct_nl[] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, INT_MAX };
		static const int dayct_lp[] = { 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, INT_MAX };
		while ((isl ? dayct_lp : dayct_nl)[result->tm_mon] < result->tm_yday)
			result->tm_mon++;
		result->tm_mon--;
		dayct -= (isl ? dayct_lp : dayct_nl)[result->tm_mon]; /* 0 based */
		result->tm_mday = dayct + 1; /* 1 based */
		/* time logic */
		rem = *timep % 86400;
		result->tm_hour = rem / 3600;
		rem %= 3600;
		result->tm_min = rem / 60;
		rem %= 60;
		result->tm_sec = rem;
		/* gmtime isdst=0 */
		return result;
}

struct tm* gmtime(const time_t* timep)
{
		static struct tm lts;
		return gmtime_r(timep, &lts);
}

struct tm* localtime_r(const time_t* timep, struct tm* result)
{
		/*TODO: +- time_t offset */
		return gmtime_r(timep, result);
}

struct tm* localtime(const time_t* timep)
{
		static struct tm lts;
		return localtime_r(timep, &lts);
}

double difftime(time_t end, time_t beg)
{
		return (double)(end - beg); /* our time_t is in seconds */
}

typedef int SItype __attribute__ ((mode (SI)));
typedef unsigned int USItype __attribute__ ((mode (SI)));
typedef int DItype __attribute__ ((mode (DI)));
typedef unsigned int UDItype __attribute__ ((mode(DI)));
/*typedef int TItype __attribute__ ((mode (TI)));
typedef unsigned int UTItype __attribute__ ((mode (TI)));*/
#define Wtype SItype
#define UWtype USItype /* SI->DI */
#define HWtype DItype
#define UHWtype UDItype
#define DWtype DItype /*DI->TI*/
#define UDWtype UDItype

struct DWstruct { Wtype low, high; };
typedef union {
		struct DWstruct s;
		DWtype ll;
} DWunion;

static inline __attribute__ ((__always_inline__))
UDWtype
__udivmoddi4 (UDWtype n, UDWtype d, UDWtype *rp)
{
		UDWtype q = 0, r = n, y = d;
		UWtype lz1, lz2, i, k;
		if (y <= r)
		{
				lz1 = __builtin_clzll (d);
				lz2 = __builtin_clzll (n);

				k = lz1 - lz2;
				y = (y << k);
				if (r >= y)
				{
						r = r - y;
						q =  (1ULL << k);
				}

				if (k > 0)
				{
						y = y >> 1;
						i = k;
						do
						{
								if (r >= y)
										r = ((r - y) << 1) + 1;
								else
										r =  (r << 1);
								i = i - 1;
						} while (i != 0);
						q = q + r;
						r = r >> k;
						q = q - (r << k);
				}
		}

		if (rp)
				*rp = r;
		return q;
}

UDWtype
__umoddi3 (UDWtype u, UDWtype v)
{
		UDWtype w;

		(void) __udivmoddi4 (u, v, &w);

		return w;
}

UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
		return __udivmoddi4 (n, d, (UDWtype *) 0);
}

DWtype
__moddi3 (DWtype u, DWtype v)
{
		Wtype c = 0;
		DWunion uu = {.ll = u};
		DWunion vv = {.ll = v};
		DWtype w;
	
		if (uu.s.high < 0)
				c = ~c,
					uu.ll = -uu.ll;
		if (vv.s.high < 0)
				vv.ll = -vv.ll;
	
		(void) __udivmoddi4 (uu.ll, vv.ll, (UDWtype*)&w);
		if (c)
				w = -w;
	
		return w;
}

DWtype
__divdi3 (DWtype u, DWtype v)
{
		Wtype c = 0;
		DWunion uu = {.ll = u};
		DWunion vv = {.ll = v};
		DWtype w;
	
		if (uu.s.high < 0)
				c = ~c,
				  uu.ll = -uu.ll;
		if (vv.s.high < 0)
				c = ~c,
				  vv.ll = -vv.ll;
	
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
		if (c)
				w = -w;
	
		return w;
}

