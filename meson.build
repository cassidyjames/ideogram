project('com.github.cassidyjames.ideogram', 'vala', 'c')

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

asresources = gnome.compile_resources(
    'as-resources', join_paths('data', 'gresource.xml'),
    source_dir: 'data',
    c_name: 'as'
)

executable(
    meson.project_name(),
    asresources,
    join_paths('src', 'Application.vala'),
    join_paths('src', 'MainWindow.vala'),
    join_paths('src', 'Settings', 'CustomShortcutSettings.vala'),
    dependencies: [
        dependency('gdk-x11-3.0'),
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('x11'),
        dependency('xtst'),
        meson.get_compiler('vala').find_library('posix'),
    ],
    install: true
)

subdir('data')
subdir('po')

meson.add_install_script(join_paths('meson', 'post_install.py'))
