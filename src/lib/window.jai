init_window :: () -> Window_Context {
    ctx: Window_Context;
    ctx.target = create_window(defaults.win_w, defaults.win_h, defaults.title);
    ctx.w      = defaults.win_w;
    ctx.h      = defaults.win_h;
    ctx.ren_w  = defaults.ren_w;
    ctx.ren_h  = defaults.ren_h;

    set_render_target(ctx.target);

    return ctx;
}