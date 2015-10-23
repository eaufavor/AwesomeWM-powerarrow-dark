local awful = require("awful")
local utils = require("utils")
local tyrannical = require("tyrannical")
local config = require("forgotten")

local function five_layout(c,tag)
    local count = #match:clients() + 1
    if count == 2 then
        awful.layout.set(awful.layout.suit.tile,tag)
        awful.tag.setproperty(tag,"nmaster",1)
        awful.tag.setproperty(tag,"mwfact",0.5)
    elseif count > 2 and count < 5 then
        awful.layout.set(awful.layout.suit.tile,tag)
        awful.tag.setproperty(tag,"nmaster",1)
        awful.tag.setproperty(tag,"mwfact",0.6)
    elseif count == 5 then
        awful.tag.setproperty(tag,"nmaster",2)
        awful.tag.setproperty(tag,"mwfact",0.63) -- 100 columns at 1080p 11px fonts
        awful.client.setwfact(0.66, awful.client.getmaster(awful.tag.getscreen(tag)))
    end
    return 5
end

-- }}}

local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

tags = {} --TODO remove


tyrannical.settings.block_children_focus_stealing = true
tyrannical.settings.group_children = true
tyrannical.settings.default_layout =  awful.layout.suit.tile
tyrannical.settings.mwfact = 0.66

tyrannical.tags = {
    {
        name = "Term",
        init        = true                                           ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("final-term.svg")       ,
        screen      = {config.scr.pri, config.scr.sec} ,
        layout      = awful.layout.suit.tile                         ,
        focus_new   = true                                           ,
        selected    = true,
--         nmaster     = 2,
--         mwfact      = 0.6,
        index       = 1,
        max_clients = five_layout,
        class       = {
            "xterm" , "urxvt" , "Terminator","URxvt","XTerm"
        },
    } ,
    {
        name = "Internet",
        init        = true                                           ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("google-chrome.svg") ,
        screen      = config.scr.pri                          ,
        layout      = awful.layout.suit.max                          ,
        clone_on    = 2,
        class = {
            "Opera"         , "Firefox"        , "Rekonq"    , "Chrome"        , "Arora",
            "Chromium"      , "nightly"        , "Nightly"   , "minefield"    , "Minefield",
            "luakit",	"google-chrome-stable" , "chrome"    , "google-chrome"
        }
    } ,
    {
        name = "Edit",
        init        = true                                           ,
        exclusive   = false                                           ,
--                     screen      = {config.scr.pri, config.scr.sec}     ,
        icon        = utils.tools.invertedIconPath("sublime_text.svg")     ,
        layout      = awful.layout.suit.tile.bottom                  ,
        class = { 
            "subl3"        , "GVim"           , "Emacs"     , "Code::Blocks" , "DDD"               }
    } ,
    {
        name = "Files",
        init        = true                                           ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("file-manager.svg")     ,
        screen      = config.scr.pri                          ,
        layout      = awful.layout.suit.tile                         ,
        exec_once   = {"dolphin"},
        no_focus_stealing_in = true,
        max_clients = five_layout,
        class  = { 
            "Thunar"        , "Konqueror"      , "Dolphin"   , "ark"          , "Nautilus",         }
    } ,
    {
        name = "Develop",
     init        = true                                              ,
        exclusive   = true                                           ,
--                     screen      = {config.scr.pri, config.scr.sec}     ,
        icon        = utils.tools.invertedIconPath("eclipse.svg")        ,
        layout      = awful.layout.suit.max                          ,
        class ={ 
            "Kate"          , "KDevelop"       , "Codeblocks", "Code::Blocks" , "DDD", "kate4", "texstudio"             }
    } ,
    {
        name = "Media",
        init        = false                                           ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("media.png")      ,
        layout      = awful.layout.suit.max                          ,
        class = { 
            "Xine"          , "xine Panel"     , "xine*"     , "MPlayer"      , "GMPlayer",
            "XMMS" }
    } ,
    {
        name = "Doc",
    --  init        = true                                           ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("evince.svg")       ,
--                     screen      = config.scr.music                          ,
        layout      = awful.layout.suit.tile                          ,
        force_screen= true                                           ,
        class       = {
            "Assistant"     , "Okular"         , "Evince"    , "EPDFviewer"   , "xpdf",
            "Xpdf"			, "Wps"       , "llpp"        ,                        }
    } ,


    -----------------VOLATILE TAGS-----------------------
    {
        name        = "Imaging",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("image.png")      ,
        layout      = awful.layout.suit.max                          ,
        class       = {"Inkscape"      , "KolourPaint"    , "Krita"     , "Karbon"       , "Karbon14"}
    } ,
    {
        name        = "Picture",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("image.png")      ,
        layout      = awful.layout.suit.max                          ,
        class       = {"Digikam"       , "F-Spot"         , "GPicView"  , "ShowPhoto"    , "KPhotoAlbum"}
    } ,
    {
        name        = "Video",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("video.png")      ,
        layout      = awful.layout.suit.max                          ,
        class       = {"KDenLive"      , "Cinelerra"      , "AVIDeMux"  , "Kino"}
    } ,
    {
        name        = "Movie",
        init        = false                                          ,
        position    = 12                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("video.png")      ,
        layout      = awful.layout.suit.max                          ,
        class       = {"VLC"}
    } ,
    {
        name        = "BBS",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("3d.png")         ,
        layout      = awful.layout.suit.max             ,
        class       = {"fqterm.bin"       , "Maya"           , "K-3D"      , "KPovModeler"  , }
    } ,
    {
        name        = "Music",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        screen      = config.scr.music or config.scr.pri             ,
        force_screen= true                                           ,
        icon        = utils.tools.invertedIconPath("media.png")      ,
        layout      = awful.layout.suit.max                          ,
        class       = {"Amarok"        , "SongBird"       , "last.fm"   ,}
    } ,
    {
        name        = "Down",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("download.png")   ,
        layout      = awful.layout.suit.max                          ,
        class       = {"Transmission"  , "KGet"}
    } ,
    {
        name        = "Office",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("office.png")     ,
        layout      = awful.layout.suit.max                          ,
        class       = {
            "OOWriter"      , "OOCalc"         , "OOMath"    , "OOImpress"    , "OOBase"       ,
            "SQLitebrowser" , "Silverun"       , "Workbench" , "KWord"        , "KSpread"      ,
            "KPres","Basket", "openoffice.org" , "OpenOffice.*"               ,                }
    } ,
    {
        name        = "RSS",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("rss.png")        ,
        layout      = awful.layout.suit.max                          ,
        class       = {}
    } ,
    {
        name        = "Chat",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        screen      = config.scr.sec or config.scr.sec ,
        icon        = utils.tools.invertedIconPath("empathy.svg")       ,
        layout      = awful.layout.suit.tile                         ,
        class       = {"Pidgin"        , "Kopete"         ,}
    } ,
    {
        name        = "Burning",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        icon        = utils.tools.invertedIconPath("burn.png")       ,
        layout      = awful.layout.suit.tile                         ,
        class       = {"k3b"}
    } ,
    {
        name        = "Mail",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
--         screen      = config.scr.sec or config.scr.pri     ,
        icon        = utils.tools.invertedIconPath("mail2.png")      ,
        layout      = awful.layout.suit.max                          ,
        class       = {"Thunderbird"   , "kmail"          , "evolution" ,}
    } ,
    {
        name        = "IRC",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = true                                           ,
        screen      = config.scr.irc or config.scr.pri ,
        init        = true                                           ,
        spawn       = "konversation"                                 ,
        icon        = utils.tools.invertedIconPath("irc.png")        ,
        force_screen= true                                           ,
        layout      = awful.layout.suit.fair                         ,
        exec_once   = {"konversation"},
        class       = {"Konversation"  , "Botch"          , "WeeChat"   , "weechat"      , "irssi"}
    } ,
    {
        name        = "Test",
        init        = false                                          ,
        position    = 99                                             ,
        exclusive   = false                                          ,
        screen      = config.scr.sec or config.scr.pri     ,
        leave_kills = true                                           ,
        persist     = true                                           ,
        icon        = utils.tools.invertedIconPath("tools.png")      ,
        layout      = awful.layout.suit.max                          ,
        class       = {}
    } ,
    {
        name        = "Config",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = false                                          ,
        icon        = utils.tools.invertedIconPath("tools.png")      ,
        layout      = awful.layout.suit.max                        ,
        class       = {"Systemsettings", "Kcontrol"       , "gconf-editor"}
    } ,
    {
        name        = "Game",
        init        = false                                          ,
        screen      = config.scr.pri                          ,
        position    = 10                                             ,
        exclusive   = false                                          ,
        icon        = utils.tools.invertedIconPath("game.png")       ,
        force_screen= true                                           ,
        layout      = awful.layout.suit.max                        ,
        class       = {"sauer_client"  , "Cube 2$"        , "Cube 2: Sauerbraten"        ,}
    } ,
    {
        name        = "Gimp",
        init        = false                                          ,
        position    = 10                                             ,
        exclusive   = false                                          ,
        icon        = utils.tools.invertedIconPath("gimp.svg")      ,
        layout      = awful.layout.tile                              ,
        nmaster     = 1                                              ,
        incncol     = 10                                             ,
        ncol        = 2                                              ,
        mwfact      = 0.00                                           ,
        class       = {"gimp"}
    } ,
    {
        name        = "Other",
        init        = true                                           ,
        position    = 15                                             ,
        exclusive   = false                                          ,
        selected    = true                                           ,
        icon        = utils.tools.invertedIconPath("term.png")       ,
        max_clients = 5                                              ,
        screen      = {3, 4, 5}                                      ,
        layout      = awful.layout.suit.tile                         ,
        class       = {}
    } ,
    {
        name        = "MediaCenter",
        init        = true                                           ,
        position    = 15                                             ,
        exclusive   = false                                          ,
        icon        = utils.tools.invertedIconPath("video.png")      ,
        max_clients = 5                                              ,
        screen      = config.scr.media or config.scr.pri   ,
        init        = "mythfrontend"                                 ,
        layout      = awful.layout.suit.tile                         ,
        class       = {"mythfrontend"  , "xbmc" , "xbmc.bin"        ,}
    } ,
}

tyrannical.properties.intrusive = {
    "ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"           ,
    "feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color",
    "kcolorchooser" , "plasmoidviewer" , "plasmaengineexplorer" , "Xephyr" , "kruler"     ,
    "yakuake"       ,
    "sflphone-client-kde", "sflphone-client-gnome", "xev", "feh"
}
tyrannical.properties.floating = {
    "MPlayer"      , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
    "xine"         , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
    "yakuake"      , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
    "New Form"     , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer" ,
    "sflphone-client-kde", "sflphone-client-gnome", "xev", 
    amarok = false , "yakuake"
}

tyrannical.properties.ontop = {
    "Xephyr"       , "ksnapshot"       , "kruler",
}

tyrannical.properties.maximize = { "subl3", 
    amarok = false,
}

-- tyrannical.properties.border_width = {
--     URxvt = 0
-- }

tyrannical.properties.border_color = {
    URxvt = "#0A1535"
}

tyrannical.properties.centered = { "kcalc" }

tyrannical.properties.skip_taskbar = {"yakuake"}
tyrannical.properties.hidden = {"yakuake"}

-- tyrannical.properties.no_autofocus = {"umbrello"}

tyrannical.properties.size_hints_honor = { xterm = false, URxvt = false, aterm = false, sauer_client = false, mythfrontend  = false}
