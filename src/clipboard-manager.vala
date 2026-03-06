using Gtk;
using Gee;

public class ClipboardManager : Object {

    public ArrayList<string> history = new ArrayList<string>();
    private Clipboard clipboard;
    private string last_text = "";
    private int max_items = 50;

    public signal void history_changed();

    public ClipboardManager () {

        clipboard = Clipboard.get(Gdk.SELECTION_CLIPBOARD);

        Timeout.add(600, () => {
            check_clipboard();
            return true;
        });
    }

    void check_clipboard() {

        string text = clipboard.wait_for_text();

        if (text != null && text != last_text && text.strip() != "") {

            history.insert(0, text);
            last_text = text;

            if (history.size > max_items) {
                history.remove_at(history.size - 1);
            }

            history_changed();
        }
    }

    public void copy_again(string text) {
        clipboard.set_text(text, -1);
    }

    public ArrayList<string> search(string query) {

        var results = new ArrayList<string>();

        foreach (var item in history) {

            if (item.down().contains(query.down())) {
                results.add(item);
            }
        }

        return results;
    }

    // hapus item tertentu
    public void remove_item(string text) {

        for (int i = 0; i < history.size; i++) {

            if (history[i] == text) {
                history.remove_at(i);
                break;
            }
        }

        history_changed();
    }

    // hapus semua history
    public void clear_all() {

        history.clear();

        history_changed();
    }
}