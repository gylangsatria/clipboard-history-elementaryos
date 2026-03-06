using Gtk;

public class ClipboardApp : Gtk.Application {

    ClipboardManager manager;

    public ClipboardApp() {
        Object(application_id: "com.example.clipboardhistory");
    }

    protected override void activate() {

        manager = new ClipboardManager();

        var win = new MainWindow(this, manager);

        new ClipboardIndicator(win, manager);

        win.show_all();
    }

    public static int main(string[] args) {
        return new ClipboardApp().run(args);
    }
}