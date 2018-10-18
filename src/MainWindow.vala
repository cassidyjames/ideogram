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
            hide_titlebar_when_maximized: true,
            icon_name: "com.github.cassidyjames.ideogram",
            resizable: false,
            title: _("Ideogram"),
            window_position: Gtk.WindowPosition.CENTER
        );
    }

    construct {
        get_style_context ().add_class ("ideogram");

        stick ();
        set_keep_above (!is_terminal);
        skip_taskbar_hint = !is_terminal;

        entry = new Gtk.Entry ();
        entry.get_style_context ().add_class ("hidden");

        var close_button = new Gtk.Button.from_icon_name ("window-close-symbolic", Gtk.IconSize.DIALOG);
        close_button.get_style_context ().add_class ("close");

        var grid = new Gtk.Grid ();
        grid.halign = grid.valign = Gtk.Align.CENTER;

        grid.attach (entry, 0, 0);
        grid.attach (close_button, 0, 1);

        add (grid);
        maximize ();

        entry.changed.connect (() => {
            Gtk.Clipboard.get_default (this.get_display ()).set_text (entry.text, -1);
            hide ();
            paste ();
            close ();
        });

        close_button.clicked.connect (() => {
            close ();
        });
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

