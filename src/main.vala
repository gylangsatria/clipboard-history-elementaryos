using Gtk;

public class ClipboardApp : Gtk.Application {

    ClipboardHistory manager;

    public ClipboardApp() {
        Object(application_id: "com.example.clipboardhistory");
    }

    protected override void activate() {

        manager = new ClipboardHistory();

        var win = new MainWindow(this, manager);

        win.show_all();
    }

    public static int main(string[] args) {
        return new ClipboardApp().run(args);
    }
}