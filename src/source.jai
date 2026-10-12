// Jai unity build, all imports and default values go here

#import "Basic";
#import "Window_Creation";
#import "Basic";
#import "Simp";
#import "Input";
#import "Math";

#load "lib/window.jai";
#load "lib/draw.jai";
#load "lib/input.jai";
#load "lib/system.jai";

should_quit := false;

defaults :: struct {
    build_path      :: "build/xenocyte";
    version         :: "0.1a";

    title           :: tprint("Xenocyte - %", defaults.version);

    win_w           :: 1280;
    win_h           :: 720;
    ren_w           :: 1280;
    ren_h           :: 720;

    r               :: 0;
    g               :: 0;
    b               :: 0;

    font_size       :: 32;
    padding         :: 16;
}

runtime : struct {
    font            : *Dynamic_Font;
    font_size       : int;
    halign          : string;
    ctx             : *Window_Context;
}

inputs :: struct {
    exit            :: 0; // 27 is standard, 1 is wayland, Jai defaults to 0 for some reason
}

Window_Context :: struct {
    target: Window_Type;
    w, h:   int;
    ren_w, ren_h: int;
}

Message_Box :: struct {
    texture: string;
    width:   float;
    height:  float;
    
    inset_left:   float;
    inset_right:  float;
    inset_top:    float;
    inset_bottom: float;
}