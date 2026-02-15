/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* ============================================================================== */
/* APPEARANCE                                   */
/* ============================================================================== */

static const unsigned int borderpx  = 2;   /* border pixel of windows */
static const unsigned int snap      = 32;  /* snap pixel */
static const unsigned int gappx     = 5;   /* gaps between windows */
static const int showbar            = 1;   /* 0 means no bar */
static const int topbar             = 0;   /* 0 means bottom bar */

static const char *fonts[]          = { "IBM Plex Mono:size=11" };
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";

static const char *colors[][3]      = {
    /*                 fg         bg         border   */
    [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
    [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* ============================================================================== */
/* TAGGING                                     */
/* ============================================================================== */

static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
    /* xprop(1):
     * WM_CLASS(STRING) = instance, class
     * WM_NAME(STRING) = title
     */
    /* class              instance    title       tags mask     isfloating   monitor */
    { "Alacritty",        NULL,       NULL,       1 << 0,       0,           -1 },
    { "St",               NULL,       NULL,       1 << 0,       0,           -1 },
    { "zen",              NULL,       NULL,       1 << 1,       0,           -1 },
    { "obsidian",         NULL,       NULL,       1 << 1,       0,           -1 },
    { "vesktop",          NULL,       NULL,       1 << 2,       0,           -1 },
    { "equibop",          NULL,       NULL,       1 << 2,       0,           -1 },
    { "thunderbird",      NULL,       NULL,       1 << 2,       0,           -1 },
    { "discord",          NULL,       NULL,       1 << 2,       0,           -1 },
    { "Discord",          NULL,       NULL,       1 << 2,       0,           -1 },
    { "steam",            NULL,       NULL,       1 << 3,       0,           -1 },
    { "gnome-calculator", NULL,       NULL,       0,            1,           -1 },
};

/* ============================================================================== */
/* LAYOUTS                                     */
/* ============================================================================== */

static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[T]",      tile },    /* first entry is default */
    { "[F]",      NULL },    /* no layout function means floating behavior */
    { "[M]",      monocle },
};

/* ============================================================================== */
/* COMMANDS                                     */
/* ============================================================================== */

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* Applications */
static const char *termcmd[]     = { "st", NULL };
static const char *browsercmd[]  = { "zen", NULL };
static const char *nautiluscmd[] = { "nautilus", NULL };
static const char *calculator[]  = { "gnome-calculator", NULL };

/* Rofi Menus */
static const char *rofidrun[]    = { "rofi", "-show", "drun", "-show-icons", NULL };
static const char *rofipower[]   = { "rofi", "-show", "power-menu", "-modi", "power-menu:rofi-power-menu", NULL };
static const char *emoji_menu[]  = { "rofi", "-show", "emoji", "-modi", "emoji", NULL};
static const char *wallpicker[]  = { "wall-picker", NULL };

/* Hardware / Media */
static const char *upvol[]       = { "volume-control", "up", NULL };
static const char *downvol[]     = { "volume-control", "down", NULL };
static const char *mutevol[]     = { "volume-control", "mute", NULL };
static const char *mutemic[]     = { "mic-control", "toggle", NULL };
static const char *upbl[]        = { "brightness-control", "up", NULL };
static const char *downbl[]      = { "brightness-control", "down", NULL };
static const char *medplay[]     = { "playerctl", "play-pause", NULL };
static const char *mednext[]     = { "playerctl", "next", NULL };
static const char *medprev[]     = { "playerctl", "previous", NULL };

/* ============================================================================== */
/* KEY BINDINGS                                   */
/* ============================================================================== */

#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

static Key keys[] = {
    /* modifier                     key                       function        argument */

    /* --- Applications --- */
    { MODKEY,                       XK_Return,                spawn,          {.v = termcmd } },
    { MODKEY,                       XK_a,                     spawn,          {.v = rofidrun } },
    { MODKEY,                       XK_b,                     spawn,          {.v = browsercmd } },
    { MODKEY,                       XK_e,                     spawn,          {.v = nautiluscmd } },
    { MODKEY,                       XK_y,                     spawn,          {.v = wallpicker } },
    { MODKEY,                       XK_period,                spawn,          {.v = emoji_menu } },
    { MODKEY,                       XK_F12,                   spawn,          {.v = calculator} },
    { MODKEY,                       XK_v,                     spawn,          SHCMD("clipcat-menu") },
    { Mod1Mask,                     XK_F4,                    spawn,          {.v = rofipower } },

    /* --- Window Management --- */
    { MODKEY,                       XK_j,                     focusdir,       {.i = 3 } },
    { MODKEY,                       XK_k,                     focusdir,       {.i = 2 } },
    { MODKEY,                       XK_h,                     focusdir,       {.i = 0 } },
    { MODKEY,                       XK_l,                     focusdir,       {.i = 1 } },
    { Mod1Mask,                     XK_j,                     focusstack,     {.i = +1 } },
    { Mod1Mask,                     XK_k,                     focusstack,     {.i = -1 } },
    { Mod1Mask,                     XK_h,                     setmfact,       {.f = -0.05} },
    { Mod1Mask,                     XK_l,                     setmfact,       {.f = +0.05} },
    { Mod1Mask,                     XK_space,                 zoom,           {0} },
    { MODKEY,                       XK_Tab,                   view,           {0} },
    { MODKEY,                       XK_q,                     killclient,     {0} },
    { Mod1Mask,                     XK_b,                     togglebar,      {0} },

    /* --- Layouts --- */
    { MODKEY,                       XK_t,                     setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_d,                     setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_f,                     togglefullscr,  {0} },
    { MODKEY,                       XK_space,                 togglefloating, {0} },

    /* --- Session --- */
    { MODKEY|ShiftMask,             XK_Escape,                quit,           {0} },

    /* --- Hardware / Media Keys --- */
    { 0,                            XF86XK_AudioRaiseVolume,  spawn,          {.v = upvol } },
    { 0,                            XF86XK_AudioLowerVolume,  spawn,          {.v = downvol } },
    { 0,                            XF86XK_AudioMute,         spawn,          {.v = mutevol } },
    { 0,                            XF86XK_AudioMicMute,      spawn,          {.v = mutemic } },
    { 0,                            XF86XK_MonBrightnessUp,   spawn,          {.v = upbl } },
    { 0,                            XF86XK_MonBrightnessDown, spawn,          {.v = downbl } },
    { 0,                            XF86XK_AudioPlay,         spawn,          {.v = medplay } },
    { 0,                            XF86XK_AudioNext,         spawn,          {.v = mednext } },
    { 0,                            XF86XK_AudioPrev,         spawn,          {.v = medprev } },

    /* --- Screenshots --- */
    { 0,                            XK_Print,                 spawn,          SHCMD("maim | xclip -selection clipboard -t image/png") },
    { MODKEY,                       XK_Print,                 spawn,          SHCMD("maim -s | xclip -selection clipboard -t image/png") },

    /* --- Tags --- */
    TAGKEYS(                        XK_1,                                     0)
    TAGKEYS(                        XK_2,                                     1)
    TAGKEYS(                        XK_3,                                     2)
    TAGKEYS(                        XK_4,                                     3)
    TAGKEYS(                        XK_5,                                     4)
};

/* ============================================================================== */
/* MOUSE BUTTONS                                   */
/* ============================================================================== */

static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "true", NULL };
