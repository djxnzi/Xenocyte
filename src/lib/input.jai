input :: () {
    for event : events_this_frame {
        if event.type == {
            case .QUIT;
                should_quit = true;

            case .KEYBOARD; if event.key_pressed {
                    if cast(u32) event.key_code == inputs.exit {
                        should_quit = true;
                    }
                }
        }
    }
}