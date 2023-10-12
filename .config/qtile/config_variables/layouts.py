from libqtile import layout

from config_variables.conf import LayoutsConfig

layouts = [
    layout.MonadTall(**LayoutsConfig.MONAD),
    layout.MonadWide(**LayoutsConfig.MONAD),
    layout.Max(**LayoutsConfig.MAX),
    layout.Matrix(),
]
