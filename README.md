# misc_minmik
Used for various purposes

## Key remapping
My laptop uses ALT_R for Hangul and CTRL_R for Hangul_Hanja \\
So, we need to remap keybindings to properly use those keys: \\
link: [https://askubuntu.com/questions/296155/how-can-i-remap-keyboard-keys](https://askubuntu.com/questions/296155/how-can-i-remap-keyboard-keys) \

for my MSI laptop, keybindings are like this: \

```shell
keycode 105 = Control_R NoSymbol Control_R
keycode 108 = Alt_R Meta_R Alt_R Meta_R
```

I tried many solutions. But the most effective one is changing the xkbmap itself. \
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
The problem occurs from 'us' which includes 'level3'. \
In file 'level 3', change the configuration including text Alt_R or Meta_R to Hangul. \
``` shell
------------------------before------------------------
partial modifier_keys
xkb_symbols "ralt_alt" {
  key <RALT> {
    type[Group1]="TWO_LEVEL",
    type[Group2]="TWO_LEVEL",
    type[Group3]="TWO_LEVEL",
    type[Group4]="TWO_LEVEL",
    symbols[Group1] = [ Alt_R, Meta_R ],
    symbols[Group2] = [ Alt_R, Meta_R ],
    symbols[Group3] = [ Alt_R, Meta_R ],
    symbols[Group4] = [ Alt_R, Meta_R ]
  };
  modifier_map Mod1 { <RALT> };
};

------------------------after------------------------
partial modifier_keys
xkb_symbols "ralt_alt" {
  key <RALT> {
    type[Group1]="ONE_LEVEL",
    type[Group2]="ONE_LEVEL",
    type[Group3]="ONE_LEVEL",
    type[Group4]="ONE_LEVEL",
    symbols[Group1] = [ Hangul ],
    symbols[Group2] = [ Hangul ],
    symbols[Group3] = [ Hangul ],
    symbols[Group4] = [ Hangul ]
  };
  modifier_map Mod1 { <RALT> };
};
```
