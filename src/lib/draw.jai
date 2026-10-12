set_font_size :: (size: int) -> *Dynamic_Font {
    font := get_font_at_size("res", "gamestation.otf", size);
    runtime.font      = font;
    runtime.font_size = size;
    return font;
}

set_halign :: (align: string = "left") {
    if (align == "left") runtime.halign = "left";
    if (align == "right") runtime.halign = "right";
}

draw_text :: (text: string, x: float, y: float, color: Vector3 = .{1, 1, 1}) {
    using runtime.ctx;

    if !runtime.font_size  set_font_size(defaults.font_size);
    if !runtime.halign      set_halign("left");

    text_x := cast(int) x + defaults.padding;
    text_y := cast(int) y - runtime.font.character_height - defaults.padding;

    prepare_text(runtime.font, text);
    draw_prepared_text(runtime.font, text_x, text_y, .{color.x, color.y, color.z, 1});
}

draw_textbox :: (text: string, x: float = 0, y: float = 0, width: float = 0, height: float = 0, color: Vector3 = .{1, 1, 1}) {
    using runtime.ctx;

    if !runtime.font_size   set_font_size(defaults.font_size);
    if !runtime.halign      set_halign("left");

    inset: float = 8;
    box_x: float = 0;
    box_y: float = 0;
    box_width: float = 0;
    box_height: float = 0;
    text_x: float = 0;
    text_y: float = 0;
    text_height := runtime.font.character_height;
    text_width := get_text_width(runtime.font, text);

    if height == 0 {
        box_height = cast(float) text_height + defaults.padding;
    } else {
        box_height = height + defaults.padding;
    }
    if y == 9999 { // bottom
        box_y = defaults.padding;
    } else {
        box_y = cast(float) ren_h - box_height - (defaults.padding * 2);
    }

    if width == 0 {
        box_width = cast(float) text_width + defaults.padding;
    } else {
        box_width = width + (defaults.padding * 2);
    }

    if (x == 9999) {
        box_x = cast(float) ren_w - box_width - defaults.padding;
    } else {
        box_x = x + defaults.padding;
    }

    if (runtime.halign == "left") text_x = box_x - (defaults.padding / 2);
    if (runtime.halign == "right") text_x = box_x + box_width - text_width - (defaults.padding * 1.5);


    text_y += box_y + box_height + defaults.padding;
    

    message_box := Message_Box.{
        texture      = "res/message_box.png",
        width        = box_width,
        height       = box_height,
        inset_left   = inset,
        inset_right  = inset,
        inset_top    = inset,
        inset_bottom = inset
    };

    draw_nine_slice(message_box, box_x, box_y);
    draw_text(text, text_x, text_y, color);
}

draw_nine_slice :: (box: Message_Box, x: float, y: float) {
    tex: Texture;
    success := texture_load_from_file(*tex, box.texture);
    if !success  return;

    tw := cast(float) tex.width;
    th := cast(float) tex.height;
    w  := cast(float) box.width;
    h  := cast(float) box.height;

    il := cast(float) box.inset_left;
    ir := cast(float) box.inset_right;
    it := cast(float) box.inset_top;
    ib := cast(float) box.inset_bottom;

    sx := float.[0, il, tw - ir, tw];
    sy := float.[0, ib, th - it, th];
    dx := float.[x, x + il, x + w - ir, x + w];
    dy := float.[y, y + ib, y + h - it, y + h];

    set_shader_for_images(*tex);

    for row: 0..2 {
        for col: 0..2 {
            u0 := sx[col]     / tw;   v0 := sy[row]     / th;
            u1 := sx[col + 1] / tw;   v1 := sy[row + 1] / th;

            immediate_quad(
                .{dx[col],     dy[row]},
                .{dx[col + 1], dy[row]},
                .{dx[col + 1], dy[row + 1]},
                .{dx[col],     dy[row + 1]},
                .{1, 1, 1, 1},
                .{u0, v0}, .{u1, v0}, .{u1, v1}, .{u0, v1});
        }
    }
}