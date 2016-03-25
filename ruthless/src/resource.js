var res = {
    //HelloWorld_png : "res/HelloWorld.png",
    // ui image resource
    igMainBg : "res/ui/main_bg.png",
    igDialogBg : "res/ui/dialog_bg.png",
    igTitle : "res/ui/title.png",
    igGameBg : "res/ui/game_main_bg.png",
    //loading-page
    igBarBg : "res/ui/loading-page/bar_background.png",
    igBarFront : "res/ui/loading-page/bar_front.png",
    igBarSlider : "res/ui/loading-page/bar_slider.png",
    igTipFrame : "res/ui/loading-page/tip_frame.png",
    igGarlic : "res/ui/loading-page/garlic.png",
    // main-page
    igBtnArcade : "res/ui/main-page/btn_arcade.png",
    igBtnChallenge : "res/ui/main-page/btn_challenge.png",
    igBtnClassics : "res/ui/main-page/btn_classics.png",
    igBtnMenu : "res/ui/main-page/btn_menu.png",

    //menu-page
    igBtnClose : "res/ui/menu-page/btn_close.png",
    igBtnAboutGame : "res/ui/menu-page/btn_about_game.png",
    igBtnExitGame : "res/ui/menu-page/btn_exit_game.png",
    igBtnSettingGame : "res/ui/menu-page/btn_setting_game.png",
    //menu-page/setting
    igHighNormal : "res/ui/menu-page/setting/high_normal.png",
    igHighSelected : "res/ui/menu-page/setting/high_selected.png",
    igLowNormal : "res/ui/menu-page/setting/low_normal.png",
    igLowSelected : "res/ui/menu-page/setting/low_selected.png",
    igMiddleNormal : "res/ui/menu-page/setting/middle_normal.png",
    igMiddleSelected : "res/ui/menu-page/setting/middle_selected.png",
    igMusicCloseNormal : "res/ui/menu-page/setting/music_close_normal.png",
    igMusicCloseSelected : "res/ui/menu-page/setting/music_close_selected.png",
    igMusicOpenNormal : "res/ui/menu-page/setting/music_open_normal.png",
    igMusicOpenSelected : "res/ui/menu-page/setting/music_open_selected.png",
    igBtnMusic : "res/ui/menu-page/setting/music.png",
    igBtnDifficult : "res/ui/menu-page/setting/difficult.png",

    // menu-page/play-page
    igBtnBackArrows : "res/ui/play-page/back_arrows.png",
    igNumberBg : "res/ui/play-page/number_bg.png",
    igStar : "res/ui/play-page/star.png",
    igBtnCancel : "res/ui/play-page/btn_cancel.png",
    igBtnOk : "res/ui/play-page/btn_ok.png",
    igScoreFrame : "res/ui/play-page/score_frame.png",

};

var g_resources = [];
for (var i in res) {
    g_resources.push(res[i]);
}

// 还不明白有什么用
//jsb.fileUtils.addSearchPath("res/ui/");
//jsb.fileUtils.addSearchPath("res/eff/");
