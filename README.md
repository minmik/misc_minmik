# misc_minmik
Used for various purposes

## Key remapping
My laptop uses ALT_R for Hangul and CTRL_R for Hangul_Hanja \
So, we need to remap keybindings to properly use those keys: \
link: [https://dev.to/0xbf/remap-keys-in-the-keyboard-in-ubuntu-5a36](https://dev.to/0xbf/remap-keys-in-the-keyboard-in-ubuntu-5a36) \

I use a slightly different solution for my case by putting
``` shell
xmodmap -e "keycode 108 = Hangul NoSymbol Hangul" && xmodmap -e "keycode 105 = Hangul_Hanja NoSymbol Hangul_Hanja"
```
to the "Startup Applications"

link: [https://askubuntu.com/questions/296155/how-can-i-remap-keyboard-keys](https://askubuntu.com/questions/296155/how-can-i-remap-keyboard-keys) \
