class ConnectionStrings {
  static String serverHostname = "";
  static const int _port = 3001;
  static const int mouseTrackerPort = 3002;

  static void setHostName(String hostname) {
    serverHostname = hostname;
  }

  static String getHostName() {
    return serverHostname;
  }

  static String _resolveHostname() {
    return "http://$serverHostname:$_port/";
  }

  static String _resolveWebSocketName() {
    return "ws://$serverHostname:$_port";
  }

  static String getOpenWebApiUrl() {
    return "${_resolveHostname()}open/web";
  }

  static String _getSetVolumeApiUrl() {
    return "${_resolveHostname()}set/volume";
  }

  static String _getVideoControlApiUrl() {
    return "${_resolveHostname()}set/video";
  }

  static String _getSlideShowApiUrl() {
    return "${_resolveHostname()}set/slides";
  }

  static String getMouseSocketApiUrl() {
    return "${_resolveWebSocketName()}/set/mouse";
  }

  static String _getNavigationApiUrl() {
    return "${_resolveHostname()}set/navigation";
  }

  static String getTypeApiUrl() {
    return "${_resolveHostname()}typing";
  }

  static String getMouseSetterApiUrl() {
    return "${_resolveHostname()}set/mouse";
  }

  // Audio controls

  static String setVolumeMuteApiUrl() {
    return "${_getSetVolumeApiUrl()}/mute";
  }

  static String setVolumeUpApiUrl() {
    return "${_getSetVolumeApiUrl()}/up";
  }

  static String setVolumeDownApiUrl() {
    return "${_getSetVolumeApiUrl()}/down";
  }

  // Video Controls

  static String toggleVideoPlayPauseApiUrl() {
    return "${_getVideoControlApiUrl()}/playpause";
  }

  static String rewindVideoApiUrl() {
    return "${_getVideoControlApiUrl()}/rewind";
  }

  static String forwardVideoApiUrl() {
    return "${_getVideoControlApiUrl()}/forward";
  }

  static String nextTrackApiUrl() {
    return "${_getVideoControlApiUrl()}/next";
  }

  static String prevTrackApiUrl() {
    return "${_getVideoControlApiUrl()}/prev";
  }

  static String toggleFullscreenVideoApiUrl() {
    return "${_getVideoControlApiUrl()}/fsn";
  }

  // SlideShow Controls
  static String nextSlideUrl() {
    return "${_getSlideShowApiUrl()}/next";
  }

  static String prevSlideUrl() {
    return "${_getSlideShowApiUrl()}/prev";
  }

  static String nextItemSlideUrl() {
    return "${_getSlideShowApiUrl()}/forward";
  }

  static String prevItemSlideUrl() {
    return "${_getSlideShowApiUrl()}/rewind";
  }

  static String switchModeSlide() {
    return "${_getSlideShowApiUrl()}/switchmode";
  }

  // Navigation Controls

  static String enterApiUrl() {
    return "${_getNavigationApiUrl()}/enter";
  }

  static String lbApiUrl() {
    return "${_getNavigationApiUrl()}/lb";
  }

  static String rbApiUrl() {
    return "${_getNavigationApiUrl()}/rb";
  }


}
