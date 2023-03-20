/* kbd.h: Contains definitions for the keyboard
 *        handling system such as scancodes and functions
 **/

#define KBD_INIT_BUFSIZE 0x200

/* shift alt ctrl caps num scr*/
#define KBD_STATE_SCROLL_LOCK   0x01
#define KBD_STATE_NUM_LOCK      0x02
#define KBD_STATE_CAPS_LOCK     0x04
#define KBD_STATE_CONTROL       0x08
#define KBD_STATE_ALT           0x10
#define KBD_STATE_SHIFT         0x20
#define KBD_STATE_LCONTROL      0x40
#define KBD_STATE_LALT          0x80
#define KBD_STATE_LSHIFT       0x100
#define KBD_STATE_RCONTROL     0x200
#define KBD_STATE_RALT         0x400
#define KBD_STATE_RSHIFT       0x800
#define KBD_STATE_NEXT_RIGHT  0x1000
#define KBD_LIGHT_SCROLL_LOCK 0x2000
#define KBD_LIGHT_NUM_LOCK    0x4000
#define KBD_LIGHT_CAPS_LOCK   0x8000
#define KBD_LIGHT_MASK        0xe000

/* keyboard command queue entries
 * */
#define KBC_RESET      0x01
#define KBC_DISABLE    0x02
#define KBC_ENABLE     0x03
#define KBC_SET_LIGHTS 0x04 /* followed by single byte */

struct key_event
{
		uint8_t prs; /* press or relase event */
		uint8_t sc; /* sc enum members */
		uint16_t state; /* status of the control keys */
};

void kbd_init();
void kbd_handler();
void kbd_handle_sc(uint8_t sc);
void kbd_process_queue();
int kbd_event_present(); /* >0 if key_events are available */
struct key_event kbd_get_event();
int kbd_enqueue_command(uint8_t cmd, void* data);
int kbd_event_translate(const struct key_event* ke);

