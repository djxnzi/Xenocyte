sys :: (ctx: *Window_Context) {
    using ctx;

    runtime.ctx = ctx;

    while !should_quit {

        input();

        clear_render_target(defaults.r, defaults.g, defaults.b, 1.0);
        update_window_events();

        for get_window_resizes() {
            if it.window == target {
                w     = it.width;
                h     = it.height;
                ren_w = w;
                ren_h = h;
                update_window(target);
            }
        }

        set_font_size(32);

        draw_textbox("this is a test of a 9 slice message box");

        swap_buffers(target);
        sleep_milliseconds(10);
        reset_temporary_storage();
    }
}