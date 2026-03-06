using Gtk;

public class ClipboardIndicator : Gtk.StatusIcon {

    MainWindow window;

    public ClipboardIndicator(MainWindow win) {

        window = win;

        set_from_icon_name("edit-paste");
        set_tooltip_text("Clipboard History");

        activate.connect(() => {

            if (window.visible)
                window.hide();
            else
                window.show_all();
        });
    }
}