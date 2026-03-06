using Gtk;
using Granite;

public class MainWindow : Gtk.ApplicationWindow {

    ClipboardManager manager;

    Gtk.SearchEntry search;
    Gtk.ListBox list;

    public MainWindow(Gtk.Application app, ClipboardManager manager) {

        Object(application: app,
               title: "Clipboard History",
               default_width: 420,
               default_height: 500);

        this.manager = manager;

        var header = new Gtk.HeaderBar();
        header.show_close_button = true;
        header.title = "Clipboard History";

        set_titlebar(header);

        var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 6);
        box.margin = 12;

        search = new Gtk.SearchEntry();
        search.placeholder_text = "Search clipboard";

        list = new Gtk.ListBox();
        list.selection_mode = SelectionMode.NONE;

        var scroll = new Gtk.ScrolledWindow(null, null);
        scroll.add(list);

        box.pack_start(search, false, false, 0);
        box.pack_start(scroll, true, true, 0);

        add(box);

        manager.history_changed.connect(refresh_list);

        search.changed.connect(() => {
            refresh_list();
        });

        show_all();
    }

    void refresh_list() {

        foreach (Widget child in list.get_children()) {
            list.remove(child);
        }

        var query = search.text;

        var items = query == "" ? manager.history : manager.search(query);

        foreach (var text in items) {

            var row = new Gtk.ListBoxRow();

            var row_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 6);

            var label = new Gtk.Label(text);
            label.wrap = true;
            label.xalign = 0;

            var button = new Gtk.Button.with_label("Copy");

            button.clicked.connect(() => {
                manager.copy_again(text);
            });

            row_box.pack_start(label, true, true, 0);
            row_box.pack_end(button, false, false, 0);

            row.add(row_box);
            list.add(row);
        }

        list.show_all();
    }
}