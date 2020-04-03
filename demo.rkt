#lang at-exp racket

(require "util.rkt")

(define (speed-up clip speed)
  (define old-len (video-file-length clip))
  (define len     (scale-video-length old-len (/ 1 speed)))
  (define len-s   (video-length->string len))

  @~a{
<?xml version="1.0" encoding="utf-8"?>
<mlt LC_NUMERIC="C" version="6.19.0" title="Shotcut version 19.12.31" producer="main_bin">
  <profile description="HD 1080p 25 fps" width="1920" height="1080" progressive="1" sample_aspect_num="1" sample_aspect_den="1" display_aspect_num="16" display_aspect_den="9" frame_rate_num="60" frame_rate_den="1" colorspace="709"/>
  <playlist id="main_bin">
    <property name="xml_retain">1</property>
  </playlist>
  <producer id="black" in="00:00:00.000" out="@len-s">
    <property name="length">@|len-s|</property>
    <property name="eof">pause</property>
    <property name="resource">0</property>
    <property name="aspect_ratio">1</property>
    <property name="mlt_service">color</property>
    <property name="mlt_image_format">rgb24a</property>
    <property name="set.test_audio">0</property>
  </producer>
  <playlist id="background">
    <entry producer="black" in="00:00:00.000" out="@len-s"/>
  </playlist>
  <producer id="producer0" title="Anonymous Submission" in="00:00:00.000" out="@len-s">
    <property name="length">@|len-s|</property>
    <property name="eof">pause</property>
    <property name="resource">@|speed|:@|clip|</property>
    <property name="aspect_ratio">1</property>
    <property name="seekable">1</property>
    <property name="audio_index">1</property>
    <property name="video_index">0</property>
    <property name="mute_on_pause">1</property>
    <property name="warp_speed">@|speed|</property>
    <property name="warp_resource">@|clip|</property>
    <property name="mlt_service">timewarp</property>
    <property name="shotcut:producer">avformat</property>
    <property name="video_delay">0</property>
    <property name="shotcut:hash">b311f5837112df2bd14fffda4013497c</property>
    <property name="shotcut:skipConvert">1</property>
    <property name="global_feed">1</property>
    <property name="xml">was here</property>
    <property name="shotcut:caption">@clip (@|speed|x)</property>
    <filter id="filter0" out="@len-s">
      <property name="background">colour:0</property>
      <property name="mlt_service">affine</property>
      <property name="shotcut:filter">affineRotate</property>
      <property name="transition.invert_scale">1</property>
      <property name="transition.fix_rotate_x">180</property>
      <property name="transition.scale_x">1</property>
      <property name="transition.scale_y">1</property>
      <property name="transition.ox">0</property>
      <property name="transition.oy">0</property>
      <property name="transition.threads">0</property>
    </filter>
  </producer>
  <playlist id="playlist0">
    <property name="shotcut:video">1</property>
    <property name="shotcut:name">V1</property>
    <entry producer="producer0" in="00:00:00.000" out="@len-s"/>
  </playlist>
  <tractor id="tractor0" title="Shotcut version 19.12.31" global_feed="1" in="00:00:00.000" out="@len-s">
    <property name="shotcut">1</property>
    <property name="shotcut:projectAudioChannels">2</property>
    <property name="shotcut:projectFolder">0</property>
    <track producer="background"/>
    <track producer="playlist0"/>
    <transition id="transition0">
      <property name="a_track">0</property>
      <property name="b_track">1</property>
      <property name="mlt_service">mix</property>
      <property name="always_active">1</property>
      <property name="sum">1</property>
    </transition>
    <transition id="transition1">
      <property name="a_track">0</property>
      <property name="b_track">1</property>
      <property name="version">0.9</property>
      <property name="mlt_service">frei0r.cairoblend</property>
      <property name="disable">1</property>
    </transition>
  </tractor>
</mlt>
  })

(module+ main
	 (define clip
	   (first (vector->list (current-command-line-arguments))))

	 (define v
	   (build-path 
	     (current-directory)
	     clip))

	 (displayln 
	   (speed-up v 
		     (string->number (second (vector->list (current-command-line-arguments)))))))








