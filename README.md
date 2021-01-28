# misc_minmik
Used for various purposes

## Key remapping
My laptop uses ALT_R for Hangul and CTRL_R for Hangul_Hanja. \
So, we need to remap keybindings to properly use those keys: \
link: [https://askubuntu.com/questions/296155/how-can-i-remap-keyboard-keys](https://askubuntu.com/questions/296155/how-can-i-remap-keyboard-keys)

for my MSI laptop, keybindings are like this:
```shell
keycode 105 = Control_R NoSymbol Control_R
keycode 108 = Alt_R Meta_R Alt_R Meta_R
```

I tried many solutions. But the most effective one is changing the xkbmap itself.
```shell
$ setxkbmap -print
xkb_keymap {
	xkb_keycodes  { include "evdev+aliases(qwerty)"	};
	xkb_types     { include "complete"	};
	xkb_compat    { include "complete"	};
	xkb_symbols   { include "pc+kr+us:2+inet(evdev)"	};
	xkb_geometry  { include "pc(pc105)"	};
};
```

The important part in this is the xkb_symbols. \
It includes 'pc', 'kr', 'us' and 'inet'. \
The files can be found in "/usr/share/X11/xkb/symbols" \
The problem occurs from 'pc'.\
'pc' includes "altwin(meta_alt)" \
so we need to change from file 'altwin' like this:
``` shell
------------------------before------------------------
// Meta is mapped to second level of Alt.
partial modifier_keys
xkb_symbols "meta_alt" {
    key <LALT> { [ Alt_L, Meta_L ] };
    key <RALT> { type[Group1] = "TWO_LEVEL",
                 symbols[Group1] = [ Alt_R, Meta_R ] };
    modifier_map Mod1 { Alt_L, Alt_R, Meta_L, Meta_R };
//  modifier_map Mod4 {};
};

------------------------after------------------------
// Meta is mapped to second level of Alt.
partial modifier_keys
xkb_symbols "meta_alt" {
    key <LALT> { [ Alt_L, Meta_L ] };
    key <RALT> { type[Group1] = "ONE_LEVEL",
                 symbols[Group1] = [ Hangul ] };
    modifier_map Mod1 { Alt_L, Meta_L };
//  modifier_map Mod4 {};
};
```

Also, to use Hangul_Hanja key, we need to change like this in file 'pc':
``` shell
------------------------before------------------------
    key <RCTL> {	[ Control_R		]	};
    
------------------------after------------------------
    key <RCTL> {	[ Hangul_Hanja		]	};
```

reboot and everything will be fine. \
Now finish ibus-setup to support Hangul and Hangul_Hanja keys. \
link: [https://pstudio411.tistory.com/entry/Ubuntu-2004-%ED%95%9C%EA%B8%80-%EC%9E%85%EB%A0%A5-%EB%B0%A9%EB%B2%95](https://pstudio411.tistory.com/entry/Ubuntu-2004-%ED%95%9C%EA%B8%80-%EC%9E%85%EB%A0%A5-%EB%B0%A9%EB%B2%95)
