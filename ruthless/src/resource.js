var res = {
    //HelloWorld_png : "res/HelloWorld.png",
    // ui image resource
    igMainBg : "res/ui/main_bg.png",
    igDialogBg : "res/ui/dialog_bg.png",
    igTitle : "res/ui/title.png",
        //loading-page
    igBarBg : "res/ui/loading-page/bar_background.png",
    igBarFront : "res/ui/loading-page/bar_front.png",
    igBarSlider : "res/ui/loading-page/garlic.png",
    igTipFrame : "res/ui/loading-page/tip_frame.png",
        // main-page
    igBtnArcade : "res/ui/main-page/btn_arcade.png",
    igBtnChallenge : "res/ui/main-page/btn_challenge.png",
    igBtnClassics : "res/ui/main-page/btn_classics.png",
    igBtnMenu : "res/ui/main-page/btn_menu.png",
};

var g_resources = [];
for (var i in res) {
    g_resources.push(res[i]);
}

// 还不明白有什么用
//jsb.fileUtils.addSearchPath("res/ui/");
//jsb.fileUtils.addSearchPath("res/eff/");
