/* longmath.c : Implements the bootloader support for complex 64-bit
 *              arithmetic in 32-bit mode. Taken from the gcc implementation.
 * */

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

