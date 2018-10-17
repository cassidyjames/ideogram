project ('com.github.cassidyjames.ideogram', 'vala', 'c')

gnome = import ('gnome')
i18n = import ('i18n')

add_global_arguments ('-DGETTEXT_PACKAGE="' + meson.project_name () + '"', language:'c')

# asresources = gnome.compile_resources(
#     'as-resources', join_paths ('data', 'gresource.xml'),
#     source_dir: 'data',
#     c_name: 'as'
# )

executable(
    meson.project_name (),
    # asresources,
    join_paths ('src', 'Application.vala'),
    join_paths ('src', 'MainWindow.vala'),
    dependencies: [
        dependency ('glib-2.0'),
        dependency ('gtk+-3.0')
    ],
    install: true
)

subdir ('data')

meson.add_install_script (join_paths ('meson', 'post_install.py'))

