using Gtk;
using AppIndicator;

public class ClipboardIndicator : Object {

    AppIndicator.Indicator indicator;
    Gtk.Menu menu;

    MainWindow window;
    ClipboardManager manager;

    public ClipboardIndicator(MainWindow win, ClipboardManager manager) {

        this.window = win;
        this.manager = manager;

        indicator = new AppIndicator.Indicator(
            "clipboard-history",
            "edit-paste",
            AppIndicator.IndicatorCategory.APPLICATION_STATUS
        );

        indicator.set_status(AppIndicator.IndicatorStatus.ACTIVE);

        build_menu();
    }

    void build_menu() {

        menu = new Gtk.Menu();

        var open = new Gtk.MenuItem.with_label("Show Clipboard");

        open.activate.connect(() => {
            window.show_all();
        });

        var clear = new Gtk.MenuItem.with_label("Clear History");

        clear.activate.connect(() => {
            manager.clear_all();
        });

        var quit = new Gtk.MenuItem.with_label("Quit");

        quit.activate.connect(() => {
            Gtk.main_quit();
        });

        menu.append(open);
        menu.append(clear);
        menu.append(new Gtk.SeparatorMenuItem());
        menu.append(quit);

        menu.show_all();

        indicator.set_menu(menu);
    }
}