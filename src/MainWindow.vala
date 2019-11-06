/*
* Copyright ⓒ 2018 Cassidy James Blaede (https://cassidyjames.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Cassidy James Blaede <c@ssidyjam.es>
*/

public class MainWindow : Gtk.Window {
    private Gtk.Entry entry;
    private bool is_terminal = Posix.isatty (Posix.STDIN_FILENO);

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            height_request: 580,
            icon_name: "com.github.cassidyjames.ideogram",
            resizable: false,
            skip_taskbar_hint: true,
            title: _("Ideogram"),
            width_request: 580,
            window_position: Gtk.WindowPosition.CENTER_ALWAYS
        );
    }

    construct {
        get_style_context ().add_class ("ideogram");

        stick ();
        set_keep_above (true);

        entry = new Gtk.Entry ();
        entry.halign = Gtk.Align.CENTER;
        entry.width_request = entry.height_request = 0;
        entry.get_style_context ().add_class ("hidden");

        var title = new Gtk.Label (_("Select Emoji to Insert"));
        title.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

        var copy = new Gtk.Label (_("Selecting will copy the emoji to the clipboard and paste into any focused text input."));
        copy.max_width_chars = 50;
        copy.wrap = true;

        var fake_window = new Gtk.Grid ();
        fake_window.halign = Gtk.Align.CENTER;
        fake_window.row_spacing = 12;
        fake_window.valign = Gtk.Align.END;
        fake_window.get_style_context ().add_class ("fake-window");

        fake_window.attach (title, 0, 0);
        fake_window.attach (copy, 0, 1);

        var grid = new Gtk.Grid ();
        grid.halign = Gtk.Align.CENTER;
        grid.valign = Gtk.Align.END;

        grid.attach (entry, 0, 0);
        grid.attach (fake_window, 0, 1);

        add (grid);
        entry.grab_focus ();

        entry.changed.connect (() => {
            Gtk.Clipboard.get_default (this.get_display ()).set_text (entry.text, -1);
            hide ();
            paste ();
            close ();
        });

        if (is_terminal == false) {
            entry.focus_in_event.connect (() => {
                close ();
            });

            focus_out_event.connect ((event) => {
                close ();
                return Gdk.EVENT_STOP;
            });
        }
    }

    public override void map () {
        base.map ();

        // NOTE: have to do it here to get focus
        entry.insert_emoji ();
    }

    // From Clipped: https://github.com/davidmhewitt/clipped/blob/edac68890c2a78357910f05bf44060c2aba5958e/src/ClipboardManager.vala
    private void paste () {
        perform_key_event ("<Control>v", true, 100);
        perform_key_event ("<Control>v", false, 0);
    }

    private static void perform_key_event (string accelerator, bool press, ulong delay) {
        uint keysym;
        Gdk.ModifierType modifiers;
        Gtk.accelerator_parse (accelerator, out keysym, out modifiers);
        unowned X.Display display = Gdk.X11.get_default_xdisplay ();
        int keycode = display.keysym_to_keycode (keysym);

        if (keycode != 0) {
            if (Gdk.ModifierType.CONTROL_MASK in modifiers) {
                int modcode = display.keysym_to_keycode (Gdk.Key.Control_L);
                XTest.fake_key_event (display, modcode, press, delay);
            }

            if (Gdk.ModifierType.SHIFT_MASK in modifiers) {
                int modcode = display.keysym_to_keycode (Gdk.Key.Shift_L);
                XTest.fake_key_event (display, modcode, press, delay);
            }

            XTest.fake_key_event (display, keycode, press, delay);
        }
    }
}
