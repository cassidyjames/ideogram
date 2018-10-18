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

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            // decorated: false, // NOTE: Have to decorate, otherwise there's a black background
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
        // set_keep_above (true);

        entry = new Gtk.Entry ();
        entry.enable_emoji_completion = true;

        var temp = new Gtk.Button.from_icon_name ("face-cool");
        temp.clicked.connect (() => {
            entry.insert_emoji ();
        });

        var grid = new Gtk.Grid ();
        grid.halign = grid.valign = Gtk.Align.CENTER;
        grid.add (entry);
        grid.add (temp);

        add (grid);
        maximize ();

        entry.changed.connect (() => {
            Gtk.Clipboard.get_default (this.get_display ()).set_text (entry.text, -1);
            hide ();
        });
    }

    public override void map () {
        base.map ();
        entry.insert_emoji ();
    }
}

