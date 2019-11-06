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

public class Ideogram : Gtk.Application {
    public const string SHORTCUT = "<Super>e";
    public const string ID = "com.github.cassidyjames.ideogram";

    public Ideogram () {
        Object (application_id: ID,
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        if (get_windows ().length () > 0) {
            get_windows ().data.present ();
            return;
        }

        var main_window = new MainWindow (this);

        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {"Escape"});

        quit_action.activate.connect (() => {
            if (main_window != null) {
                main_window.destroy ();
            }
        });

        const string DESKTOP_SCHEMA = "io.elementary.desktop";
        const string DARK_KEY = "prefer-dark";

        var lookup = SettingsSchemaSource.get_default ().lookup (DESKTOP_SCHEMA, false);

        if (lookup != null) {
            var desktop_settings = new Settings (DESKTOP_SCHEMA);
            var gtk_settings = Gtk.Settings.get_default ();
            desktop_settings.bind (
              DARK_KEY, gtk_settings,
              "gtk_application_prefer_dark_theme",
              SettingsBindFlags.DEFAULT
            );
        }

        // CSS provider
        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/cassidyjames/ideogram/Application.css");
        Gtk.StyleContext.add_provider_for_screen (
          Gdk.Screen.get_default (),
          provider,
          Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        main_window.show_all ();

        // Set shortcut
        CustomShortcutSettings.init ();
        bool has_shortcut = false;
        foreach (var shortcut in CustomShortcutSettings.list_custom_shortcuts ()) {
            if (shortcut.command == ID) {
                // CustomShortcutSettings.edit_shortcut (shortcut.relocatable_schema, SHORTCUT);
                has_shortcut = true;
                return;
            }
        }
        if (!has_shortcut) {
            var shortcut = CustomShortcutSettings.create_shortcut ();
            if (shortcut != null) {
                CustomShortcutSettings.edit_shortcut (shortcut, SHORTCUT);
                CustomShortcutSettings.edit_command (shortcut, ID);
            }
        }
    }

    private static int main (string[] args) {
        // NOTE: Workaround for https://github.com/cassidyjames/ideogram/issues/26
        // Without GTK_CSD set, the fake window won't be styled correctly.

        GLib.Environment.set_variable ("GTK_CSD", "1", true);

        Gtk.init (ref args);

        var app = new Ideogram ();
        return app.run (args);
    }
}
