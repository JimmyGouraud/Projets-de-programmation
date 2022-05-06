﻿// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 902.2KB

// Skipping shader variants that would not be included into build of current scene.

Shader "StandardToon" {
Properties {
 _Color ("Color", Color) = (1,1,1,1)
 _MainTex ("Albedo", 2D) = "white" { }
 _Ramp ("Toon Ramp (RGB)", 2D) = "gray" {} 
 _Cutoff ("Alpha Cutoff", Range(0,1)) = 0.5
 _Glossiness ("Smoothness", Range(0,1)) = 0.5
[Gamma]  _Metallic ("Metallic", Range(0,1)) = 0
 _MetallicGlossMap ("Metallic", 2D) = "white" { }
 _BumpScale ("Scale", Float) = 1
 _BumpMap ("Normal Map", 2D) = "bump" { }
 _Parallax ("Height Scale", Range(0.005,0.08)) = 0.02
 _ParallaxMap ("Height Map", 2D) = "black" { }
 _OcclusionStrength ("Strength", Range(0,1)) = 1
 _OcclusionMap ("Occlusion", 2D) = "white" { }
 _EmissionColor ("Color", Color) = (0,0,0,1)
 _EmissionMap ("Emission", 2D) = "white" { }
 _DetailMask ("Detail Mask", 2D) = "white" { }
 _DetailAlbedoMap ("Detail Albedo x2", 2D) = "grey" { }
 _DetailNormalMapScale ("Scale", Float) = 1
 _DetailNormalMap ("Normal Map", 2D) = "bump" { }
[Enum(UV0,0,UV1,1)]  _UVSec ("UV Set for secondary textures", Float) = 0
[HideInInspector]  _EmissionScaleUI ("Scale", Float) = 0
[HideInInspector]  _EmissionColorUI ("Color", Color) = (1,1,1,1)
[HideInInspector]  _Mode ("__mode", Float) = 0
[HideInInspector]  _SrcBlend ("__src", Float) = 1
[HideInInspector]  _DstBlend ("__dst", Float) = 0
[HideInInspector]  _ZWrite ("__zw", Float) = 1
}
SubShader { 
 LOD 300
 Tags { "RenderType"="Opaque" "PerformanceChecks"="False" }




CGPROGRAM
#pragma surface surf ToonRamp

sampler2D _Ramp;

// custom lighting function that uses a texture ramp based
// on angle between light direction and normal
#pragma lighting ToonRamp exclude_path:prepass
inline half4 LightingToonRamp (SurfaceOutput s, half3 lightDir, half atten)
{
    #ifndef USING_DIRECTIONAL_LIGHT
    lightDir = normalize(lightDir);
    #endif
    
    half d = dot (s.Normal, lightDir)*0.5 + 0.5;
    half3 ramp = tex2D (_Ramp, float2(d,d)).rgb;
    
    half4 c;
    c.rgb = s.Albedo * _LightColor0.rgb * ramp * (atten * 2);
    c.a = 0;
    return c;
}


sampler2D _MainTex;
float4 _Color;

struct Input {
    float2 uv_MainTex : TEXCOORD0;
};

void surf (Input IN, inout SurfaceOutput o) {
    half4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
    o.Albedo = c.rgb;
    o.Alpha = c.a;
}
ENDCG





 // Stats for Vertex shader:
 //       d3d11 : 44 avg math (33..56)
 //        d3d9 : 50 avg math (34..67)
 //      opengl : 154 avg math (154..155), 4 avg texture (4..5), 9 branch
 // Stats for Fragment shader:
 //       d3d11 : 135 avg math (134..136), 2 avg texture (2..3), 4 branch
 //        d3d9 : 148 avg math (147..149), 6 avg texture (6..7), 5 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  ZWrite [_ZWrite]
  Blend [_SrcBlend] [_DstBlend]
  GpuProgramID 35871
Program "vp" {
SubProgram "opengl " {
// Stats: 154 math, 4 textures, 9 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  vec4 tmpvar_9;
  tmpvar_9 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_15;
  vec3 x2_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_16.x = dot (unity_SHBr, tmpvar_17);
  x2_16.y = dot (unity_SHBg, tmpvar_17);
  x2_16.z = dot (unity_SHBb, tmpvar_17);
  tmpvar_6.xyz = (x2_16 + (unity_SHC.xyz * (
    (tmpvar_15.x * tmpvar_15.x)
   - 
    (tmpvar_15.y * tmpvar_15.y)
  )));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_4, vec3(_Metallic));
  float tmpvar_7;
  tmpvar_7 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_2, _WorldSpaceLightPos0.xyz));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_2;
  vec3 x1_13;
  x1_13.x = dot (unity_SHAr, tmpvar_12);
  x1_13.y = dot (unity_SHAg, tmpvar_12);
  x1_13.z = dot (unity_SHAb, tmpvar_12);
  tmpvar_10 = (xlv_TEXCOORD5.xyz + x1_13);
  tmpvar_10 = (tmpvar_10 * tmpvar_8);
  vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_3 - (2.0 * (
    dot (tmpvar_2, tmpvar_3)
   * tmpvar_2)));
  vec3 worldNormal_15;
  worldNormal_15 = tmpvar_14;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_16;
    tmpvar_16 = normalize(tmpvar_14);
    vec3 tmpvar_17;
    tmpvar_17 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_16);
    vec3 tmpvar_18;
    tmpvar_18 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_16);
    bvec3 tmpvar_19;
    tmpvar_19 = greaterThan (tmpvar_16, vec3(0.0, 0.0, 0.0));
    float tmpvar_20;
    if (tmpvar_19.x) {
      tmpvar_20 = tmpvar_17.x;
    } else {
      tmpvar_20 = tmpvar_18.x;
    };
    float tmpvar_21;
    if (tmpvar_19.y) {
      tmpvar_21 = tmpvar_17.y;
    } else {
      tmpvar_21 = tmpvar_18.y;
    };
    float tmpvar_22;
    if (tmpvar_19.z) {
      tmpvar_22 = tmpvar_17.z;
    } else {
      tmpvar_22 = tmpvar_18.z;
    };
    vec3 tmpvar_23;
    tmpvar_23 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_15 = (((
      (tmpvar_23 - unity_SpecCube0_ProbePosition.xyz)
     + xlv_TEXCOORD8) + (tmpvar_16 * 
      min (min (tmpvar_20, tmpvar_21), tmpvar_22)
    )) - tmpvar_23);
  };
  vec4 tmpvar_24;
  tmpvar_24.xyz = worldNormal_15;
  tmpvar_24.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
  vec4 tmpvar_25;
  tmpvar_25 = textureCubeLod (unity_SpecCube0, worldNormal_15, tmpvar_24.w);
  vec3 tmpvar_26;
  tmpvar_26 = ((unity_SpecCube0_HDR.x * pow (tmpvar_25.w, unity_SpecCube0_HDR.y)) * tmpvar_25.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_27;
    worldNormal_27 = tmpvar_14;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_28;
      tmpvar_28 = normalize(tmpvar_14);
      vec3 tmpvar_29;
      tmpvar_29 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_28);
      vec3 tmpvar_30;
      tmpvar_30 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_28);
      bvec3 tmpvar_31;
      tmpvar_31 = greaterThan (tmpvar_28, vec3(0.0, 0.0, 0.0));
      float tmpvar_32;
      if (tmpvar_31.x) {
        tmpvar_32 = tmpvar_29.x;
      } else {
        tmpvar_32 = tmpvar_30.x;
      };
      float tmpvar_33;
      if (tmpvar_31.y) {
        tmpvar_33 = tmpvar_29.y;
      } else {
        tmpvar_33 = tmpvar_30.y;
      };
      float tmpvar_34;
      if (tmpvar_31.z) {
        tmpvar_34 = tmpvar_29.z;
      } else {
        tmpvar_34 = tmpvar_30.z;
      };
      vec3 tmpvar_35;
      tmpvar_35 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_27 = (((
        (tmpvar_35 - unity_SpecCube1_ProbePosition.xyz)
       + xlv_TEXCOORD8) + (tmpvar_28 * 
        min (min (tmpvar_32, tmpvar_33), tmpvar_34)
      )) - tmpvar_35);
    };
    vec4 tmpvar_36;
    tmpvar_36.xyz = worldNormal_27;
    tmpvar_36.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
    vec4 tmpvar_37;
    tmpvar_37 = textureCubeLod (unity_SpecCube1, worldNormal_27, tmpvar_36.w);
    tmpvar_11 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_37.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_37.xyz), tmpvar_26, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_11 = tmpvar_26;
  };
  tmpvar_11 = (tmpvar_11 * tmpvar_8);
  vec3 viewDir_38;
  viewDir_38 = -(tmpvar_3);
  float tmpvar_39;
  tmpvar_39 = (1.0 - _Glossiness);
  vec3 tmpvar_40;
  tmpvar_40 = normalize((_WorldSpaceLightPos0.xyz + viewDir_38));
  float tmpvar_41;
  tmpvar_41 = max (0.0, dot (tmpvar_2, viewDir_38));
  float tmpvar_42;
  tmpvar_42 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_40));
  float tmpvar_43;
  tmpvar_43 = ((tmpvar_39 * tmpvar_39) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_44;
  float tmpvar_45;
  tmpvar_45 = (10.0 / log2((
    ((1.0 - tmpvar_39) * 0.968)
   + 0.03)));
  tmpvar_44 = (tmpvar_45 * tmpvar_45);
  float x_46;
  x_46 = (1.0 - tmpvar_9);
  float x_47;
  x_47 = (1.0 - tmpvar_41);
  float tmpvar_48;
  tmpvar_48 = (0.5 + ((
    (2.0 * tmpvar_42)
   * tmpvar_42) * tmpvar_39));
  float x_49;
  x_49 = (1.0 - tmpvar_42);
  float x_50;
  x_50 = (1.0 - tmpvar_41);
  vec3 tmpvar_51;
  tmpvar_51 = (((tmpvar_5 * 
    (tmpvar_10 + (_LightColor0.xyz * ((
      (1.0 + ((tmpvar_48 - 1.0) * ((
        ((x_46 * x_46) * x_46)
       * x_46) * x_46)))
     * 
      (1.0 + ((tmpvar_48 - 1.0) * ((
        ((x_47 * x_47) * x_47)
       * x_47) * x_47)))
    ) * tmpvar_9)))
  ) + (
    (max (0.0, ((
      ((1.0/(((
        ((tmpvar_9 * (1.0 - tmpvar_43)) + tmpvar_43)
       * 
        ((tmpvar_41 * (1.0 - tmpvar_43)) + tmpvar_43)
      ) + 0.0001))) * (pow (max (0.0, 
        dot (tmpvar_2, tmpvar_40)
      ), tmpvar_44) * ((tmpvar_44 + 1.0) * unity_LightGammaCorrectionConsts.y)))
     * tmpvar_9) * unity_LightGammaCorrectionConsts.x)) * _LightColor0.xyz)
   * 
    (tmpvar_6 + ((1.0 - tmpvar_6) * ((
      ((x_49 * x_49) * x_49)
     * x_49) * x_49)))
  )) + (tmpvar_11 * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((((x_50 * x_50) * x_50) * x_50) * x_50)
  ))));
  vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = tmpvar_51;
  c_1.w = tmpvar_52.w;
  c_1.xyz = tmpvar_51;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_53;
  xlat_varoutput_53.xyz = c_1.xyz;
  xlat_varoutput_53.w = 1.0;
  gl_FragData[0] = xlat_varoutput_53;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 34 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_DetailAlbedoMap_ST]
Vector 15 [_MainTex_ST]
Float 17 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [unity_SHBb]
Vector 12 [unity_SHBg]
Vector 11 [unity_SHBr]
Vector 14 [unity_SHC]
"vs_3_0
def c18, 0, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord8 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c15, c15.zwzw
abs r0.x, c17.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c16.xyxy, c16
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c10
mov o7.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
mov o5.xyz, r1
dp4 r1.x, c11, r2
dp4 r1.y, c12, r2
dp4 r1.z, c13, r2
mad o6.xyz, c14, r0.x, r1
mov o3, c18.x
mov o4, c18.x
mov o5.w, c18.x
mov o6.w, c18.x

"
}
SubProgram "d3d11 " {
// Stats: 33 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedgpginppkegjeeibjhnmjgnjolfhobmfiabaaaaaajmahaaaaadaaaaaa
cmaaaaaaliaaaaaakaabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaaiaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcpeafaaaaeaaaabaahnabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaa
egbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgaaaaaf
hccabaaaahaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaaaaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaaaaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaaaaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaak
hccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaagaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 155 math, 5 textures, 9 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  vec4 tmpvar_9;
  tmpvar_9 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_15;
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_9 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_9.zw;
  vec3 x2_19;
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_19.x = dot (unity_SHBr, tmpvar_20);
  x2_19.y = dot (unity_SHBg, tmpvar_20);
  x2_19.z = dot (unity_SHBb, tmpvar_20);
  tmpvar_6.xyz = (x2_19 + (unity_SHC.xyz * (
    (tmpvar_15.x * tmpvar_15.x)
   - 
    (tmpvar_15.y * tmpvar_15.y)
  )));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = o_16;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_4, vec3(_Metallic));
  float tmpvar_7;
  tmpvar_7 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_2, _WorldSpaceLightPos0.xyz));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_2;
  vec3 x1_14;
  x1_14.x = dot (unity_SHAr, tmpvar_13);
  x1_14.y = dot (unity_SHAg, tmpvar_13);
  x1_14.z = dot (unity_SHAb, tmpvar_13);
  tmpvar_11 = (xlv_TEXCOORD5.xyz + x1_14);
  tmpvar_10 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x);
  tmpvar_11 = (tmpvar_11 * tmpvar_8);
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_3 - (2.0 * (
    dot (tmpvar_2, tmpvar_3)
   * tmpvar_2)));
  vec3 worldNormal_16;
  worldNormal_16 = tmpvar_15;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_17;
    tmpvar_17 = normalize(tmpvar_15);
    vec3 tmpvar_18;
    tmpvar_18 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_17);
    vec3 tmpvar_19;
    tmpvar_19 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_17);
    bvec3 tmpvar_20;
    tmpvar_20 = greaterThan (tmpvar_17, vec3(0.0, 0.0, 0.0));
    float tmpvar_21;
    if (tmpvar_20.x) {
      tmpvar_21 = tmpvar_18.x;
    } else {
      tmpvar_21 = tmpvar_19.x;
    };
    float tmpvar_22;
    if (tmpvar_20.y) {
      tmpvar_22 = tmpvar_18.y;
    } else {
      tmpvar_22 = tmpvar_19.y;
    };
    float tmpvar_23;
    if (tmpvar_20.z) {
      tmpvar_23 = tmpvar_18.z;
    } else {
      tmpvar_23 = tmpvar_19.z;
    };
    vec3 tmpvar_24;
    tmpvar_24 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_16 = (((
      (tmpvar_24 - unity_SpecCube0_ProbePosition.xyz)
     + xlv_TEXCOORD8) + (tmpvar_17 * 
      min (min (tmpvar_21, tmpvar_22), tmpvar_23)
    )) - tmpvar_24);
  };
  vec4 tmpvar_25;
  tmpvar_25.xyz = worldNormal_16;
  tmpvar_25.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
  vec4 tmpvar_26;
  tmpvar_26 = textureCubeLod (unity_SpecCube0, worldNormal_16, tmpvar_25.w);
  vec3 tmpvar_27;
  tmpvar_27 = ((unity_SpecCube0_HDR.x * pow (tmpvar_26.w, unity_SpecCube0_HDR.y)) * tmpvar_26.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_28;
    worldNormal_28 = tmpvar_15;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_29;
      tmpvar_29 = normalize(tmpvar_15);
      vec3 tmpvar_30;
      tmpvar_30 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_29);
      vec3 tmpvar_31;
      tmpvar_31 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_29);
      bvec3 tmpvar_32;
      tmpvar_32 = greaterThan (tmpvar_29, vec3(0.0, 0.0, 0.0));
      float tmpvar_33;
      if (tmpvar_32.x) {
        tmpvar_33 = tmpvar_30.x;
      } else {
        tmpvar_33 = tmpvar_31.x;
      };
      float tmpvar_34;
      if (tmpvar_32.y) {
        tmpvar_34 = tmpvar_30.y;
      } else {
        tmpvar_34 = tmpvar_31.y;
      };
      float tmpvar_35;
      if (tmpvar_32.z) {
        tmpvar_35 = tmpvar_30.z;
      } else {
        tmpvar_35 = tmpvar_31.z;
      };
      vec3 tmpvar_36;
      tmpvar_36 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_28 = (((
        (tmpvar_36 - unity_SpecCube1_ProbePosition.xyz)
       + xlv_TEXCOORD8) + (tmpvar_29 * 
        min (min (tmpvar_33, tmpvar_34), tmpvar_35)
      )) - tmpvar_36);
    };
    vec4 tmpvar_37;
    tmpvar_37.xyz = worldNormal_28;
    tmpvar_37.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
    vec4 tmpvar_38;
    tmpvar_38 = textureCubeLod (unity_SpecCube1, worldNormal_28, tmpvar_37.w);
    tmpvar_12 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_38.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_38.xyz), tmpvar_27, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_12 = tmpvar_27;
  };
  tmpvar_12 = (tmpvar_12 * tmpvar_8);
  vec3 viewDir_39;
  viewDir_39 = -(tmpvar_3);
  float tmpvar_40;
  tmpvar_40 = (1.0 - _Glossiness);
  vec3 tmpvar_41;
  tmpvar_41 = normalize((_WorldSpaceLightPos0.xyz + viewDir_39));
  float tmpvar_42;
  tmpvar_42 = max (0.0, dot (tmpvar_2, viewDir_39));
  float tmpvar_43;
  tmpvar_43 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_41));
  float tmpvar_44;
  tmpvar_44 = ((tmpvar_40 * tmpvar_40) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_45;
  float tmpvar_46;
  tmpvar_46 = (10.0 / log2((
    ((1.0 - tmpvar_40) * 0.968)
   + 0.03)));
  tmpvar_45 = (tmpvar_46 * tmpvar_46);
  float x_47;
  x_47 = (1.0 - tmpvar_9);
  float x_48;
  x_48 = (1.0 - tmpvar_42);
  float tmpvar_49;
  tmpvar_49 = (0.5 + ((
    (2.0 * tmpvar_43)
   * tmpvar_43) * tmpvar_40));
  float x_50;
  x_50 = (1.0 - tmpvar_43);
  float x_51;
  x_51 = (1.0 - tmpvar_42);
  vec3 tmpvar_52;
  tmpvar_52 = (((tmpvar_5 * 
    (tmpvar_11 + (tmpvar_10 * ((
      (1.0 + ((tmpvar_49 - 1.0) * ((
        ((x_47 * x_47) * x_47)
       * x_47) * x_47)))
     * 
      (1.0 + ((tmpvar_49 - 1.0) * ((
        ((x_48 * x_48) * x_48)
       * x_48) * x_48)))
    ) * tmpvar_9)))
  ) + (
    (max (0.0, ((
      ((1.0/(((
        ((tmpvar_9 * (1.0 - tmpvar_44)) + tmpvar_44)
       * 
        ((tmpvar_42 * (1.0 - tmpvar_44)) + tmpvar_44)
      ) + 0.0001))) * (pow (max (0.0, 
        dot (tmpvar_2, tmpvar_41)
      ), tmpvar_45) * ((tmpvar_45 + 1.0) * unity_LightGammaCorrectionConsts.y)))
     * tmpvar_9) * unity_LightGammaCorrectionConsts.x)) * tmpvar_10)
   * 
    (tmpvar_6 + ((1.0 - tmpvar_6) * ((
      ((x_50 * x_50) * x_50)
     * x_50) * x_50)))
  )) + (tmpvar_12 * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((((x_51 * x_51) * x_51) * x_51) * x_51)
  ))));
  vec4 tmpvar_53;
  tmpvar_53.w = 1.0;
  tmpvar_53.xyz = tmpvar_52;
  c_1.w = tmpvar_53.w;
  c_1.xyz = tmpvar_52;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_54;
  xlat_varoutput_54.xyz = c_1.xyz;
  xlat_varoutput_54.w = 1.0;
  gl_FragData[0] = xlat_varoutput_54;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 17 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Float 19 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_3_0
def c20, 0.5, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord8 o8.xyz
mad o1.xy, v2, c17, c17.zwzw
abs r0.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c10
mov o8.xyz, r0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c20.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c20.x
mad o7.xy, r1.z, c12.zwzw, r1.xwzw
mul r1.xyz, c8, v1.y
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
mov o5.xyz, r2
dp4 r2.x, c13, r3
dp4 r2.y, c14, r3
dp4 r2.z, c15, r3
mad o6.xyz, c16, r1.x, r2
dp4 r0.z, c2, v0
mov o0, r0
mov o7.zw, r0
mov o3, c20.y
mov o4, c20.y
mov o5.w, c20.y
mov o6.w, c20.y

"
}
SubProgram "d3d11 " {
// Stats: 36 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecediecaihmcgfepcpljgncpfbmhnnbgknddabaaaaaaemaiaaaaadaaaaaa
cmaaaaaaliaaaaaaliabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheopiaaaaaa
ajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
omaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
omaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaomaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcimagaaaa
eaaaabaakdabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
adaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaad
hccabaaaaiaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaai
bcaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaaj
dcaabaaaabaaaaaaagaabaaaabaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaa
dcaaaaalmccabaaaabaaaaaaagaebaaaabaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgaaaaafhccabaaaaiaaaaaa
egacbaaaabaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaa
adaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaabaaaaaackiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaaabaaaaaackiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaaabaaaaaackiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaabaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhccabaaaagaaaaaa
egiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaagaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
ahaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 154 math, 4 textures, 9 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  vec4 tmpvar_9;
  tmpvar_9 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_15;
  vec3 x2_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_16.x = dot (unity_SHBr, tmpvar_17);
  x2_16.y = dot (unity_SHBg, tmpvar_17);
  x2_16.z = dot (unity_SHBb, tmpvar_17);
  tmpvar_6.xyz = (x2_16 + (unity_SHC.xyz * (
    (tmpvar_15.x * tmpvar_15.x)
   - 
    (tmpvar_15.y * tmpvar_15.y)
  )));
  vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosX0 - tmpvar_7.x);
  vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosY0 - tmpvar_7.y);
  vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosZ0 - tmpvar_7.z);
  vec4 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * tmpvar_18) + (tmpvar_19 * tmpvar_19)) + (tmpvar_20 * tmpvar_20));
  vec4 tmpvar_22;
  tmpvar_22 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_18 * tmpvar_15.x) + (tmpvar_19 * tmpvar_15.y)) + (tmpvar_20 * tmpvar_15.z))
   * 
    inversesqrt(tmpvar_21)
  )) * (1.0/((1.0 + 
    (tmpvar_21 * unity_4LightAtten0)
  ))));
  tmpvar_6.xyz = (tmpvar_6.xyz + ((
    ((unity_LightColor[0].xyz * tmpvar_22.x) + (unity_LightColor[1].xyz * tmpvar_22.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_22.z)
  ) + (unity_LightColor[3].xyz * tmpvar_22.w)));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_4, vec3(_Metallic));
  float tmpvar_7;
  tmpvar_7 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_2, _WorldSpaceLightPos0.xyz));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_2;
  vec3 x1_13;
  x1_13.x = dot (unity_SHAr, tmpvar_12);
  x1_13.y = dot (unity_SHAg, tmpvar_12);
  x1_13.z = dot (unity_SHAb, tmpvar_12);
  tmpvar_10 = (xlv_TEXCOORD5.xyz + x1_13);
  tmpvar_10 = (tmpvar_10 * tmpvar_8);
  vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_3 - (2.0 * (
    dot (tmpvar_2, tmpvar_3)
   * tmpvar_2)));
  vec3 worldNormal_15;
  worldNormal_15 = tmpvar_14;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_16;
    tmpvar_16 = normalize(tmpvar_14);
    vec3 tmpvar_17;
    tmpvar_17 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_16);
    vec3 tmpvar_18;
    tmpvar_18 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_16);
    bvec3 tmpvar_19;
    tmpvar_19 = greaterThan (tmpvar_16, vec3(0.0, 0.0, 0.0));
    float tmpvar_20;
    if (tmpvar_19.x) {
      tmpvar_20 = tmpvar_17.x;
    } else {
      tmpvar_20 = tmpvar_18.x;
    };
    float tmpvar_21;
    if (tmpvar_19.y) {
      tmpvar_21 = tmpvar_17.y;
    } else {
      tmpvar_21 = tmpvar_18.y;
    };
    float tmpvar_22;
    if (tmpvar_19.z) {
      tmpvar_22 = tmpvar_17.z;
    } else {
      tmpvar_22 = tmpvar_18.z;
    };
    vec3 tmpvar_23;
    tmpvar_23 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_15 = (((
      (tmpvar_23 - unity_SpecCube0_ProbePosition.xyz)
     + xlv_TEXCOORD8) + (tmpvar_16 * 
      min (min (tmpvar_20, tmpvar_21), tmpvar_22)
    )) - tmpvar_23);
  };
  vec4 tmpvar_24;
  tmpvar_24.xyz = worldNormal_15;
  tmpvar_24.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
  vec4 tmpvar_25;
  tmpvar_25 = textureCubeLod (unity_SpecCube0, worldNormal_15, tmpvar_24.w);
  vec3 tmpvar_26;
  tmpvar_26 = ((unity_SpecCube0_HDR.x * pow (tmpvar_25.w, unity_SpecCube0_HDR.y)) * tmpvar_25.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_27;
    worldNormal_27 = tmpvar_14;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_28;
      tmpvar_28 = normalize(tmpvar_14);
      vec3 tmpvar_29;
      tmpvar_29 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_28);
      vec3 tmpvar_30;
      tmpvar_30 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_28);
      bvec3 tmpvar_31;
      tmpvar_31 = greaterThan (tmpvar_28, vec3(0.0, 0.0, 0.0));
      float tmpvar_32;
      if (tmpvar_31.x) {
        tmpvar_32 = tmpvar_29.x;
      } else {
        tmpvar_32 = tmpvar_30.x;
      };
      float tmpvar_33;
      if (tmpvar_31.y) {
        tmpvar_33 = tmpvar_29.y;
      } else {
        tmpvar_33 = tmpvar_30.y;
      };
      float tmpvar_34;
      if (tmpvar_31.z) {
        tmpvar_34 = tmpvar_29.z;
      } else {
        tmpvar_34 = tmpvar_30.z;
      };
      vec3 tmpvar_35;
      tmpvar_35 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_27 = (((
        (tmpvar_35 - unity_SpecCube1_ProbePosition.xyz)
       + xlv_TEXCOORD8) + (tmpvar_28 * 
        min (min (tmpvar_32, tmpvar_33), tmpvar_34)
      )) - tmpvar_35);
    };
    vec4 tmpvar_36;
    tmpvar_36.xyz = worldNormal_27;
    tmpvar_36.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
    vec4 tmpvar_37;
    tmpvar_37 = textureCubeLod (unity_SpecCube1, worldNormal_27, tmpvar_36.w);
    tmpvar_11 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_37.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_37.xyz), tmpvar_26, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_11 = tmpvar_26;
  };
  tmpvar_11 = (tmpvar_11 * tmpvar_8);
  vec3 viewDir_38;
  viewDir_38 = -(tmpvar_3);
  float tmpvar_39;
  tmpvar_39 = (1.0 - _Glossiness);
  vec3 tmpvar_40;
  tmpvar_40 = normalize((_WorldSpaceLightPos0.xyz + viewDir_38));
  float tmpvar_41;
  tmpvar_41 = max (0.0, dot (tmpvar_2, viewDir_38));
  float tmpvar_42;
  tmpvar_42 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_40));
  float tmpvar_43;
  tmpvar_43 = ((tmpvar_39 * tmpvar_39) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_44;
  float tmpvar_45;
  tmpvar_45 = (10.0 / log2((
    ((1.0 - tmpvar_39) * 0.968)
   + 0.03)));
  tmpvar_44 = (tmpvar_45 * tmpvar_45);
  float x_46;
  x_46 = (1.0 - tmpvar_9);
  float x_47;
  x_47 = (1.0 - tmpvar_41);
  float tmpvar_48;
  tmpvar_48 = (0.5 + ((
    (2.0 * tmpvar_42)
   * tmpvar_42) * tmpvar_39));
  float x_49;
  x_49 = (1.0 - tmpvar_42);
  float x_50;
  x_50 = (1.0 - tmpvar_41);
  vec3 tmpvar_51;
  tmpvar_51 = (((tmpvar_5 * 
    (tmpvar_10 + (_LightColor0.xyz * ((
      (1.0 + ((tmpvar_48 - 1.0) * ((
        ((x_46 * x_46) * x_46)
       * x_46) * x_46)))
     * 
      (1.0 + ((tmpvar_48 - 1.0) * ((
        ((x_47 * x_47) * x_47)
       * x_47) * x_47)))
    ) * tmpvar_9)))
  ) + (
    (max (0.0, ((
      ((1.0/(((
        ((tmpvar_9 * (1.0 - tmpvar_43)) + tmpvar_43)
       * 
        ((tmpvar_41 * (1.0 - tmpvar_43)) + tmpvar_43)
      ) + 0.0001))) * (pow (max (0.0, 
        dot (tmpvar_2, tmpvar_40)
      ), tmpvar_44) * ((tmpvar_44 + 1.0) * unity_LightGammaCorrectionConsts.y)))
     * tmpvar_9) * unity_LightGammaCorrectionConsts.x)) * _LightColor0.xyz)
   * 
    (tmpvar_6 + ((1.0 - tmpvar_6) * ((
      ((x_49 * x_49) * x_49)
     * x_49) * x_49)))
  )) + (tmpvar_11 * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((((x_50 * x_50) * x_50) * x_50) * x_50)
  ))));
  vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = tmpvar_51;
  c_1.w = tmpvar_52.w;
  c_1.xyz = tmpvar_51;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_53;
  xlat_varoutput_53.xyz = c_1.xyz;
  xlat_varoutput_53.w = 1.0;
  gl_FragData[0] = xlat_varoutput_53;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 61 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 24 [_DetailAlbedoMap_ST]
Vector 23 [_MainTex_ST]
Float 25 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 18 [unity_4LightAtten0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 21 [unity_SHBb]
Vector 20 [unity_SHBg]
Vector 19 [unity_SHBr]
Vector 22 [unity_SHC]
"vs_3_0
def c26, 0, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord8 o7.xyz
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
mad o1.xy, v2, c23, c23.zwzw
abs r0.x, c25.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c24.xyxy, c24
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add o2.xyz, r0, -c14
add r1, -r0.z, c17
mov o7.xyz, r0
add r2, -r0.x, c15
add r0, -r0.y, c16
mul r3.xyz, c12, v1.y
mad r3.xyz, c11, v1.x, r3
mad r3.xyz, c13, v1.z, r3
nrm r4.xyz, r3
mul r3, r0, r4.y
mul r0, r0, r0
mad r0, r2, r2, r0
mad r2, r2, r4.x, r3
mad r2, r1, r4.z, r2
mad r0, r1, r1, r0
rsq r1.x, r0.x
rsq r1.y, r0.y
rsq r1.z, r0.z
rsq r1.w, r0.w
mov r3.y, c26.y
mad r0, r0, c18, r3.y
mul r1, r1, r2
max r1, r1, c26.x
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r4.y, r4.y
mad r0.w, r4.x, r4.x, -r0.w
mul r1, r4.yzzx, r4.xyzz
mov o5.xyz, r4
dp4 r2.x, c19, r1
dp4 r2.y, c20, r1
dp4 r2.z, c21, r1
mad r1.xyz, c22, r0.w, r2
add o6.xyz, r0, r1
mov o3, c26.x
mov o4, c26.x
mov o5.w, c26.x
mov o6.w, c26.x

"
}
SubProgram "d3d11 " {
// Stats: 53 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcbfnkjnkonblffjhbbkndngmeinfdibeabaaaaaafeakaaaaadaaaaaa
cmaaaaaaliaaaaaakaabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaaiaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefckmaiaaaaeaaaabaaclacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaa
egbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgaaaaai
pccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
pccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaafaaaaaa
abeaaaaaaaaaaaaaaaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaadaaaaaafgafbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
acaaaaaaaaaaaaajpcaabaaaaeaaaaaaagaabaiaebaaaaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaaeaaaaaaagaabaaa
abaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaa
egaobaaaaeaaaaaaegaobaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaakgakbaia
ebaaaaaaaaaaaaaaegiocaaaacaaaaaaaeaaaaaadgaaaaafhccabaaaahaaaaaa
egacbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaaeaaaaaakgakbaaa
abaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaa
egaobaaaaeaaaaaaegaobaaaacaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaa
acaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaahaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaiaaaaaa
kgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
acaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaahhccabaaaagaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaagaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 155 math, 5 textures, 9 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  vec4 tmpvar_9;
  tmpvar_9 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_15;
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_9 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_9.zw;
  vec3 x2_19;
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_19.x = dot (unity_SHBr, tmpvar_20);
  x2_19.y = dot (unity_SHBg, tmpvar_20);
  x2_19.z = dot (unity_SHBb, tmpvar_20);
  tmpvar_6.xyz = (x2_19 + (unity_SHC.xyz * (
    (tmpvar_15.x * tmpvar_15.x)
   - 
    (tmpvar_15.y * tmpvar_15.y)
  )));
  vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_7.x);
  vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_7.y);
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_7.z);
  vec4 tmpvar_24;
  tmpvar_24 = (((tmpvar_21 * tmpvar_21) + (tmpvar_22 * tmpvar_22)) + (tmpvar_23 * tmpvar_23));
  vec4 tmpvar_25;
  tmpvar_25 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_21 * tmpvar_15.x) + (tmpvar_22 * tmpvar_15.y)) + (tmpvar_23 * tmpvar_15.z))
   * 
    inversesqrt(tmpvar_24)
  )) * (1.0/((1.0 + 
    (tmpvar_24 * unity_4LightAtten0)
  ))));
  tmpvar_6.xyz = (tmpvar_6.xyz + ((
    ((unity_LightColor[0].xyz * tmpvar_25.x) + (unity_LightColor[1].xyz * tmpvar_25.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_25.z)
  ) + (unity_LightColor[3].xyz * tmpvar_25.w)));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = o_16;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_4, vec3(_Metallic));
  float tmpvar_7;
  tmpvar_7 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_2, _WorldSpaceLightPos0.xyz));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_2;
  vec3 x1_14;
  x1_14.x = dot (unity_SHAr, tmpvar_13);
  x1_14.y = dot (unity_SHAg, tmpvar_13);
  x1_14.z = dot (unity_SHAb, tmpvar_13);
  tmpvar_11 = (xlv_TEXCOORD5.xyz + x1_14);
  tmpvar_10 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x);
  tmpvar_11 = (tmpvar_11 * tmpvar_8);
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_3 - (2.0 * (
    dot (tmpvar_2, tmpvar_3)
   * tmpvar_2)));
  vec3 worldNormal_16;
  worldNormal_16 = tmpvar_15;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_17;
    tmpvar_17 = normalize(tmpvar_15);
    vec3 tmpvar_18;
    tmpvar_18 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_17);
    vec3 tmpvar_19;
    tmpvar_19 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_17);
    bvec3 tmpvar_20;
    tmpvar_20 = greaterThan (tmpvar_17, vec3(0.0, 0.0, 0.0));
    float tmpvar_21;
    if (tmpvar_20.x) {
      tmpvar_21 = tmpvar_18.x;
    } else {
      tmpvar_21 = tmpvar_19.x;
    };
    float tmpvar_22;
    if (tmpvar_20.y) {
      tmpvar_22 = tmpvar_18.y;
    } else {
      tmpvar_22 = tmpvar_19.y;
    };
    float tmpvar_23;
    if (tmpvar_20.z) {
      tmpvar_23 = tmpvar_18.z;
    } else {
      tmpvar_23 = tmpvar_19.z;
    };
    vec3 tmpvar_24;
    tmpvar_24 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_16 = (((
      (tmpvar_24 - unity_SpecCube0_ProbePosition.xyz)
     + xlv_TEXCOORD8) + (tmpvar_17 * 
      min (min (tmpvar_21, tmpvar_22), tmpvar_23)
    )) - tmpvar_24);
  };
  vec4 tmpvar_25;
  tmpvar_25.xyz = worldNormal_16;
  tmpvar_25.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
  vec4 tmpvar_26;
  tmpvar_26 = textureCubeLod (unity_SpecCube0, worldNormal_16, tmpvar_25.w);
  vec3 tmpvar_27;
  tmpvar_27 = ((unity_SpecCube0_HDR.x * pow (tmpvar_26.w, unity_SpecCube0_HDR.y)) * tmpvar_26.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_28;
    worldNormal_28 = tmpvar_15;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_29;
      tmpvar_29 = normalize(tmpvar_15);
      vec3 tmpvar_30;
      tmpvar_30 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_29);
      vec3 tmpvar_31;
      tmpvar_31 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_29);
      bvec3 tmpvar_32;
      tmpvar_32 = greaterThan (tmpvar_29, vec3(0.0, 0.0, 0.0));
      float tmpvar_33;
      if (tmpvar_32.x) {
        tmpvar_33 = tmpvar_30.x;
      } else {
        tmpvar_33 = tmpvar_31.x;
      };
      float tmpvar_34;
      if (tmpvar_32.y) {
        tmpvar_34 = tmpvar_30.y;
      } else {
        tmpvar_34 = tmpvar_31.y;
      };
      float tmpvar_35;
      if (tmpvar_32.z) {
        tmpvar_35 = tmpvar_30.z;
      } else {
        tmpvar_35 = tmpvar_31.z;
      };
      vec3 tmpvar_36;
      tmpvar_36 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_28 = (((
        (tmpvar_36 - unity_SpecCube1_ProbePosition.xyz)
       + xlv_TEXCOORD8) + (tmpvar_29 * 
        min (min (tmpvar_33, tmpvar_34), tmpvar_35)
      )) - tmpvar_36);
    };
    vec4 tmpvar_37;
    tmpvar_37.xyz = worldNormal_28;
    tmpvar_37.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
    vec4 tmpvar_38;
    tmpvar_38 = textureCubeLod (unity_SpecCube1, worldNormal_28, tmpvar_37.w);
    tmpvar_12 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_38.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_38.xyz), tmpvar_27, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_12 = tmpvar_27;
  };
  tmpvar_12 = (tmpvar_12 * tmpvar_8);
  vec3 viewDir_39;
  viewDir_39 = -(tmpvar_3);
  float tmpvar_40;
  tmpvar_40 = (1.0 - _Glossiness);
  vec3 tmpvar_41;
  tmpvar_41 = normalize((_WorldSpaceLightPos0.xyz + viewDir_39));
  float tmpvar_42;
  tmpvar_42 = max (0.0, dot (tmpvar_2, viewDir_39));
  float tmpvar_43;
  tmpvar_43 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_41));
  float tmpvar_44;
  tmpvar_44 = ((tmpvar_40 * tmpvar_40) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_45;
  float tmpvar_46;
  tmpvar_46 = (10.0 / log2((
    ((1.0 - tmpvar_40) * 0.968)
   + 0.03)));
  tmpvar_45 = (tmpvar_46 * tmpvar_46);
  float x_47;
  x_47 = (1.0 - tmpvar_9);
  float x_48;
  x_48 = (1.0 - tmpvar_42);
  float tmpvar_49;
  tmpvar_49 = (0.5 + ((
    (2.0 * tmpvar_43)
   * tmpvar_43) * tmpvar_40));
  float x_50;
  x_50 = (1.0 - tmpvar_43);
  float x_51;
  x_51 = (1.0 - tmpvar_42);
  vec3 tmpvar_52;
  tmpvar_52 = (((tmpvar_5 * 
    (tmpvar_11 + (tmpvar_10 * ((
      (1.0 + ((tmpvar_49 - 1.0) * ((
        ((x_47 * x_47) * x_47)
       * x_47) * x_47)))
     * 
      (1.0 + ((tmpvar_49 - 1.0) * ((
        ((x_48 * x_48) * x_48)
       * x_48) * x_48)))
    ) * tmpvar_9)))
  ) + (
    (max (0.0, ((
      ((1.0/(((
        ((tmpvar_9 * (1.0 - tmpvar_44)) + tmpvar_44)
       * 
        ((tmpvar_42 * (1.0 - tmpvar_44)) + tmpvar_44)
      ) + 0.0001))) * (pow (max (0.0, 
        dot (tmpvar_2, tmpvar_41)
      ), tmpvar_45) * ((tmpvar_45 + 1.0) * unity_LightGammaCorrectionConsts.y)))
     * tmpvar_9) * unity_LightGammaCorrectionConsts.x)) * tmpvar_10)
   * 
    (tmpvar_6 + ((1.0 - tmpvar_6) * ((
      ((x_50 * x_50) * x_50)
     * x_50) * x_50)))
  )) + (tmpvar_12 * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((((x_51 * x_51) * x_51) * x_51) * x_51)
  ))));
  vec4 tmpvar_53;
  tmpvar_53.w = 1.0;
  tmpvar_53.xyz = tmpvar_52;
  c_1.w = tmpvar_53.w;
  c_1.xyz = tmpvar_52;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_54;
  xlat_varoutput_54.xyz = c_1.xyz;
  xlat_varoutput_54.w = 1.0;
  gl_FragData[0] = xlat_varoutput_54;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 67 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 26 [_DetailAlbedoMap_ST]
Vector 25 [_MainTex_ST]
Vector 15 [_ProjectionParams]
Vector 16 [_ScreenParams]
Float 27 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 20 [unity_4LightAtten0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_3_0
def c28, 0.5, 0, 1, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord8 o8.xyz
mad o1.xy, v2, c25, c25.zwzw
abs r0.x, c27.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c26.xyxy, c26
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add o2.xyz, r0, -c14
dp4 r1.y, c5, v0
mul r0.w, r1.y, c15.x
mul r2.w, r0.w, c28.x
dp4 r1.x, c4, v0
dp4 r1.w, c7, v0
mul r2.xz, r1.xyww, c28.x
mad o7.xy, r2.z, c16.zwzw, r2.xwzw
add r2, -r0.z, c19
mov o8.xyz, r0
add r3, -r0.x, c17
add r0, -r0.y, c18
mul r4.xyz, c12, v1.y
mad r4.xyz, c11, v1.x, r4
mad r4.xyz, c13, v1.z, r4
nrm r5.xyz, r4
mul r4, r0, r5.y
mul r0, r0, r0
mad r0, r3, r3, r0
mad r3, r3, r5.x, r4
mad r3, r2, r5.z, r3
mad r0, r2, r2, r0
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r4.z, c28.z
mad r0, r0, c20, r4.z
mul r2, r2, r3
max r2, r2, c28.y
rcp r3.x, r0.x
rcp r3.y, r0.y
rcp r3.z, r0.z
rcp r3.w, r0.w
mul r0, r2, r3
mul r2.xyz, r0.y, c1
mad r2.xyz, c0, r0.x, r2
mad r0.xyz, c2, r0.z, r2
mad r0.xyz, c3, r0.w, r0
mul r0.w, r5.y, r5.y
mad r0.w, r5.x, r5.x, -r0.w
mul r2, r5.yzzx, r5.xyzz
mov o5.xyz, r5
dp4 r3.x, c21, r2
dp4 r3.y, c22, r2
dp4 r3.z, c23, r2
mad r2.xyz, c24, r0.w, r3
add o6.xyz, r0, r2
dp4 r1.z, c6, v0
mov o0, r1
mov o7.zw, r1
mov o3, c28.y
mov o4, c28.y
mov o5.w, c28.y
mov o6.w, c28.y

"
}
SubProgram "d3d11 " {
// Stats: 56 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbjpconohjpjlmcfaacmcenpfhdcfkdkoabaaaaaaaealaaaaadaaaaaa
cmaaaaaaliaaaaaaliabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheopiaaaaaa
ajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
omaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
omaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaomaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceeajaaaa
eaaaabaafbacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
adaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaad
hccabaaaaiaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaai
bcaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaaj
dcaabaaaabaaaaaaagaabaaaabaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaa
dcaaaaalmccabaaaabaaaaaaagaebaaaabaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgaaaaaipccabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaipccabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaa
akbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
akbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
akbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaa
bkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
bkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
bkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaa
abaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaa
abaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaa
abaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaa
aaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaacaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaaj
pcaabaaaafaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaaacaaaaaaacaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaacaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaa
egaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaakgakbaiaebaaaaaaabaaaaaa
egiocaaaacaaaaaaaeaaaaaadgaaaaafhccabaaaaiaaaaaaegacbaaaabaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaafaaaaaakgakbaaaacaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaa
egaobaaaadaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaan
pcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaa
acaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaaaaaaaaahhccabaaa
agaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaagaaaaaa
abeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 147 math, 6 textures, 5 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 15 [_Color]
Float 17 [_Glossiness]
Vector 13 [_LightColor0]
Float 16 [_Metallic]
Float 18 [_OcclusionStrength]
Vector 0 [_WorldSpaceLightPos0]
Vector 12 [unity_ColorSpaceDielectricSpec]
Vector 14 [unity_LightGammaCorrectionConsts]
Vector 3 [unity_SHAb]
Vector 2 [unity_SHAg]
Vector 1 [unity_SHAr]
Vector 4 [unity_SpecCube0_BoxMax]
Vector 5 [unity_SpecCube0_BoxMin]
Vector 7 [unity_SpecCube0_HDR]
Vector 6 [unity_SpecCube0_ProbePosition]
Vector 8 [unity_SpecCube1_BoxMax]
Vector 9 [unity_SpecCube1_BoxMin]
Vector 11 [unity_SpecCube1_HDR]
Vector 10 [unity_SpecCube1_ProbePosition]
SetTexture 0 [unity_SpecCube0] CUBE 0
SetTexture 1 [unity_SpecCube1] CUBE 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_OcclusionMap] 2D 3
"ps_3_0
def c19, 7, 0.999989986, 9.99999975e-005, 10
def c20, 0.967999995, 0.0299999993, 0, 0
def c21, 0, 1, 0.5, 0.75
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord4_pp v2.xyz
dcl_texcoord5_pp v3.xyz
dcl_texcoord8_pp v4.xyz
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
nrm_pp r0.xyz, v2
dp3_pp r1.x, v1, v1
rsq_pp r1.x, r1.x
mul_pp r1.yzw, r1.x, v1.xxyz
texld r2, v0, s2
mul_pp r3.xyz, r2, c15
mov r4, c12
mad_pp r2.xyz, c15, r2, -r4
mad_pp r2.xyz, c16.x, r2, r4
mad_pp r2.w, c16.x, -r4.w, r4.w
mul_pp r3.xyz, r2.w, r3
dp3_pp r3.w, r0, c0
max_pp r4.x, r3.w, c21.x
texld_pp r5, v0, s3
mov r6.xyz, c21
add_pp r3.w, r6.y, -c18.x
mad_pp r3.w, r5.y, c18.x, r3.w
mov r0.w, c21.y
dp4_pp r5.x, c1, r0
dp4_pp r5.y, c2, r0
dp4_pp r5.z, c3, r0
add_pp r4.yzw, r5.xxyz, v3.xxyz
dp3 r0.w, r1.yzww, r0
add r0.w, r0.w, r0.w
mad_pp r5.xyz, r0, -r0.w, r1.yzww
if_lt -c6.w, r6.x
nrm_pp r7.xyz, r5
add r8.xyz, c4, -v4
rcp r9.x, r7.x
rcp r9.y, r7.y
rcp r9.z, r7.z
mul_pp r8.xyz, r8, r9
add r10.xyz, c5, -v4
mul_pp r9.xyz, r9, r10
cmp_pp r8.xyz, -r7, r9, r8
min_pp r0.w, r8.y, r8.x
min_pp r5.w, r8.z, r0.w
mov r8.xyz, c5
add r8.xyz, r8, c4
mad r9.xyz, r8, r6.z, -c6
add r9.xyz, r9, v4
mad r7.xyz, r7, r5.w, r9
mad_pp r7.xyz, r8, -c21.z, r7
else
mov_pp r7.xyz, r5
endif
add_pp r0.w, r6.y, -c17.x
pow_pp r5.w, r0.w, c21.w
mul_pp r7.w, r5.w, c19.x
texldl_pp r8, r7, s0
pow_pp r5.w, r8.w, c7.y
mul_pp r5.w, r5.w, c7.x
mul_pp r9.xyz, r8, r5.w
mov r6.w, c5.w
if_lt r6.w, c19.y
if_lt -c10.w, r6.x
nrm_pp r10.xyz, r5
add r11.xyz, c8, -v4
rcp r12.x, r10.x
rcp r12.y, r10.y
rcp r12.z, r10.z
mul_pp r11.xyz, r11, r12
add r13.xyz, c9, -v4
mul_pp r12.xyz, r12, r13
cmp_pp r11.xyz, -r10, r12, r11
min_pp r6.x, r11.y, r11.x
min_pp r8.w, r11.z, r6.x
mov r11.xyz, c8
add r11.xyz, r11, c9
mad r6.xzw, r11.xyyz, r6.z, -c10.xyyz
add r6.xzw, r6, v4.xyyz
mad r6.xzw, r10.xyyz, r8.w, r6
mad_pp r7.xyz, r11, -c21.z, r6.xzww
else
mov_pp r7.xyz, r5
endif
texldl_pp r7, r7, s1
pow_pp r5.x, r7.w, c11.y
mul_pp r5.x, r5.x, c11.x
mul_pp r5.xyz, r7, r5.x
mad r6.xzw, r5.w, r8.xyyz, -r5.xyyz
mad_pp r9.xyz, c5.w, r6.xzww, r5
endif
mul_pp r5.xyz, r3.w, r9
mad_pp r6.xzw, v1.xyyz, -r1.x, c0.xyyz
nrm_pp r7.xyz, r6.xzww
dp3_pp r1.x, r0, r7
max_pp r5.w, r1.x, c21.x
dp3_pp r0.x, r0, -r1.yzww
max_pp r1.x, r0.x, c21.x
dp3_pp r0.x, c0, r7
max_pp r1.y, r0.x, c21.x
mul_pp r0.x, r0.w, r0.w
mul_pp r0.y, r0.x, c14.w
mad_pp r0.x, r0.x, -c14.w, r6.y
mad_pp r0.z, r4.x, r0.x, r0.y
mad_pp r0.x, r1.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c19.z
rcp_pp r0.x, r0.x
add_pp r0.y, -r0.w, c21.y
mad_pp r0.y, r0.y, c20.x, c20.y
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c19.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c21.y
mul_pp r0.y, r0.y, c14.y
pow_pp r1.z, r5.w, r0.z
mul_pp r0.y, r0.y, r1.z
add_pp r0.z, -r4.x, c21.y
mul_pp r1.z, r0.z, r0.z
mul_pp r1.z, r1.z, r1.z
mul_pp r0.z, r0.z, r1.z
add_pp r1.x, -r1.x, c21.y
mul_pp r1.z, r1.x, r1.x
mul_pp r1.z, r1.z, r1.z
mul_pp r1.x, r1.x, r1.z
mul_pp r1.z, r1.y, r1.y
dp2add_pp r0.w, r1.z, r0.w, -c21.z
mad_pp r0.z, r0.w, r0.z, c21.y
mad_pp r0.w, r0.w, r1.x, c21.y
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.xy, r4.x, r0.xzzw
mul_pp r0.x, r0.x, c14.x
add_pp r0.z, -r2.w, c21.y
add_sat_pp r0.z, r0.z, c17.x
mul_pp r6.xyz, r0.y, c13
mad_pp r4.xyz, r4.yzww, r3.w, r6
mul_pp r6.xyz, r0.x, c13
cmp_pp r0.xyw, r0.x, r6.xyzz, c21.x
add_pp r1.y, -r1.y, c21.y
mul_pp r1.z, r1.y, r1.y
mul_pp r1.z, r1.z, r1.z
mul_pp r1.y, r1.y, r1.z
lrp_pp r6.xyz, r1.y, c21.y, r2
mul_pp r0.xyw, r0, r6.xyzz
mad_pp r0.xyw, r3.xyzz, r4.xyzz, r0
lrp_pp r3.xyz, r1.x, r0.z, r2
mad_pp oC0.xyz, r5, r3, r0.xyww
mov_pp oC0.w, c21.y

"
}
SubProgram "d3d11 " {
// Stats: 134 math, 2 textures, 4 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_OcclusionMap] 2D 3
SetTexture 2 [unity_SpecCube0] CUBE 0
SetTexture 3 [unity_SpecCube1] CUBE 1
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
Float 224 [_OcclusionStrength]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
ConstBuffer "UnityReflectionProbes" 128
Vector 0 [unity_SpecCube0_BoxMax]
Vector 16 [unity_SpecCube0_BoxMin]
Vector 32 [unity_SpecCube0_ProbePosition]
Vector 48 [unity_SpecCube0_HDR]
Vector 64 [unity_SpecCube1_BoxMax]
Vector 80 [unity_SpecCube1_BoxMin]
Vector 96 [unity_SpecCube1_ProbePosition]
Vector 112 [unity_SpecCube1_HDR]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityReflectionProbes" 2
"ps_4_0
eefiecedjphdfdcnphnemldohbkfdkejcndihjieabaaaaaacibeaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apahaaaaneaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcnibcaaaaeaaaaaaalgaeaaaafjaaaaaeegiocaaa
aaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaacjaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaa
acaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
hcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacamaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahocaabaaaabaaaaaaagaabaaaabaaaaaaagbjbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaa
acaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
kgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaa
dcaaaaanicaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaacaaaaaaegacbaaaadaaaaaabaaaaaaiicaabaaaadaaaaaaegacbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaaaaaaaajbcaabaaaaeaaaaaaakiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaeaaaaaa
bkaabaaaaeaaaaaaakiacaaaaaaaaaaaaoaaaaaaakaabaaaaeaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaafaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahocaabaaaaeaaaaaaagajbaaa
afaaaaaaagbjbaaaagaaaaaabaaaaaahicaabaaaaaaaaaaajgahbaaaabaaaaaa
egacbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaa
aaaaaaaajgahbaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dkiacaaaacaaaaaaacaaaaaabpaaaeaddkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaagaaaaaapgapbaaaaaaaaaaaegacbaaa
afaaaaaaaaaaaaajhcaabaaaahaaaaaaegbcbaiaebaaaaaaahaaaaaaegiccaaa
acaaaaaaaaaaaaaaaoaaaaahhcaabaaaahaaaaaaegacbaaaahaaaaaaegacbaaa
agaaaaaaaaaaaaajhcaabaaaaiaaaaaaegbcbaiaebaaaaaaahaaaaaaegiccaaa
acaaaaaaabaaaaaaaoaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaa
agaaaaaadbaaaaakhcaabaaaajaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaaaagaaaaaadhaaaaajhcaabaaaahaaaaaaegacbaaaajaaaaaa
egacbaaaahaaaaaaegacbaaaaiaaaaaaddaaaaahicaabaaaaaaaaaaabkaabaaa
ahaaaaaaakaabaaaahaaaaaaddaaaaahicaabaaaaaaaaaaackaabaaaahaaaaaa
dkaabaaaaaaaaaaaaaaaaaajhcaabaaaahaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaabaaaaaadcaaaaaohcaabaaaaiaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegiccaiaebaaaaaaacaaaaaa
acaaaaaaaaaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegbcbaaaahaaaaaa
dcaaaaajhcaabaaaagaaaaaaegacbaaaagaaaaaapgapbaaaaaaaaaaaegacbaaa
aiaaaaaadcaaaaanhcaabaaaagaaaaaaegacbaiaebaaaaaaahaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaagaaaaaabcaaaaabdgaaaaaf
hcaabaaaagaaaaaaegacbaaaafaaaaaabfaaaaabaaaaaaajicaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpcpaaaaaficaabaaa
afaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaafaaaaaadkaabaaaafaaaaaa
abeaaaaaaaaaeadpbjaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaadiaaaaah
icaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaaaaaaoaeaeiaaaaalpcaabaaa
agaaaaaaegacbaaaagaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadkaabaaa
afaaaaaacpaaaaaficaabaaaagaaaaaadkaabaaaagaaaaaadiaaaaaiicaabaaa
agaaaaaadkaabaaaagaaaaaabkiacaaaacaaaaaaadaaaaaabjaaaaaficaabaaa
agaaaaaadkaabaaaagaaaaaadiaaaaaiicaabaaaagaaaaaadkaabaaaagaaaaaa
akiacaaaacaaaaaaadaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaaagaaaaaa
pgapbaaaagaaaaaadbaaaaaiicaabaaaahaaaaaadkiacaaaacaaaaaaabaaaaaa
abeaaaaafipphpdpbpaaaeaddkaabaaaahaaaaaadbaaaaaiicaabaaaahaaaaaa
abeaaaaaaaaaaaaadkiacaaaacaaaaaaagaaaaaabpaaaeaddkaabaaaahaaaaaa
baaaaaahicaabaaaahaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaaf
icaabaaaahaaaaaadkaabaaaahaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaa
afaaaaaapgapbaaaahaaaaaaaaaaaaajhcaabaaaajaaaaaaegbcbaiaebaaaaaa
ahaaaaaaegiccaaaacaaaaaaaeaaaaaaaoaaaaahhcaabaaaajaaaaaaegacbaaa
ajaaaaaaegacbaaaaiaaaaaaaaaaaaajhcaabaaaakaaaaaaegbcbaiaebaaaaaa
ahaaaaaaegiccaaaacaaaaaaafaaaaaaaoaaaaahhcaabaaaakaaaaaaegacbaaa
akaaaaaaegacbaaaaiaaaaaadbaaaaakhcaabaaaalaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaiaaaaaadhaaaaajhcaabaaaajaaaaaa
egacbaaaalaaaaaaegacbaaaajaaaaaaegacbaaaakaaaaaaddaaaaahicaabaaa
ahaaaaaabkaabaaaajaaaaaaakaabaaaajaaaaaaddaaaaahicaabaaaahaaaaaa
ckaabaaaajaaaaaadkaabaaaahaaaaaaaaaaaaajhcaabaaaajaaaaaaegiccaaa
acaaaaaaaeaaaaaaegiccaaaacaaaaaaafaaaaaadcaaaaaohcaabaaaakaaaaaa
egacbaaaajaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegiccaia
ebaaaaaaacaaaaaaagaaaaaaaaaaaaahhcaabaaaakaaaaaaegacbaaaakaaaaaa
egbcbaaaahaaaaaadcaaaaajhcaabaaaaiaaaaaaegacbaaaaiaaaaaapgapbaaa
ahaaaaaaegacbaaaakaaaaaadcaaaaanhcaabaaaafaaaaaaegacbaiaebaaaaaa
ajaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaiaaaaaa
bfaaaaabeiaaaaalpcaabaaaafaaaaaaegacbaaaafaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaadkaabaaaafaaaaaacpaaaaaficaabaaaafaaaaaadkaabaaa
afaaaaaadiaaaaaiicaabaaaafaaaaaadkaabaaaafaaaaaabkiacaaaacaaaaaa
ahaaaaaabjaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaadiaaaaaiicaabaaa
afaaaaaadkaabaaaafaaaaaaakiacaaaacaaaaaaahaaaaaadiaaaaahhcaabaaa
afaaaaaaegacbaaaafaaaaaapgapbaaaafaaaaaadcaaaaakhcaabaaaagaaaaaa
pgapbaaaagaaaaaaegacbaaaagaaaaaaegacbaiaebaaaaaaafaaaaaadcaaaaak
hcaabaaaahaaaaaapgipcaaaacaaaaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
afaaaaaabfaaaaabdiaaaaahhcaabaaaafaaaaaaagaabaaaaeaaaaaaegacbaaa
ahaaaaaadcaaaaalhcaabaaaagaaaaaaegbcbaiaebaaaaaaacaaaaaaagaabaaa
abaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaagaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaagaaaaaaagaabaaaabaaaaaaegacbaaaagaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaagaaaaaadeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaajgahbaiaebaaaaaaabaaaaaabaaaaaaiccaabaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaegacbaaaagaaaaaadeaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiccaabaaa
abaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaiadpdcaaaaajecaabaaaabaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaakecaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaaaaaaaaiccaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaa
aaaacaebbkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
bkiacaaaaaaaaaaaaiaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaaiccaabaaaabaaaaaadkaabaiaebaaaaaa
adaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahecaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaakgakbaaa
abaaaaaapgapbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaalpdcaaaaajccaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahmcaabaaaaaaaaaaapgapbaaaadaaaaaakgaobaaa
aaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaa
anaaaaaaaacaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaaiocaabaaaabaaaaaapgapbaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaa
dcaaaaajocaabaaaabaaaaaafgaobaaaaeaaaaaaagaabaaaaeaaaaaafgaobaaa
abaaaaaadiaaaaaihcaabaaaaeaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaalhcaabaaa
agaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaagaaaaaafgafbaaaaaaaaaaa
agajbaaaacaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
aeaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaadaaaaaafgaobaaaabaaaaaa
fgaobaaaaaaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaacaaaaaa
agaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaafaaaaaa
egacbaaaabaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 149 math, 7 textures, 5 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 15 [_Color]
Float 17 [_Glossiness]
Vector 13 [_LightColor0]
Float 16 [_Metallic]
Float 18 [_OcclusionStrength]
Vector 0 [_WorldSpaceLightPos0]
Vector 12 [unity_ColorSpaceDielectricSpec]
Vector 14 [unity_LightGammaCorrectionConsts]
Vector 3 [unity_SHAb]
Vector 2 [unity_SHAg]
Vector 1 [unity_SHAr]
Vector 4 [unity_SpecCube0_BoxMax]
Vector 5 [unity_SpecCube0_BoxMin]
Vector 7 [unity_SpecCube0_HDR]
Vector 6 [unity_SpecCube0_ProbePosition]
Vector 8 [unity_SpecCube1_BoxMax]
Vector 9 [unity_SpecCube1_BoxMin]
Vector 11 [unity_SpecCube1_HDR]
Vector 10 [unity_SpecCube1_ProbePosition]
SetTexture 0 [unity_SpecCube0] CUBE 0
SetTexture 1 [unity_SpecCube1] CUBE 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_OcclusionMap] 2D 3
SetTexture 4 [_ShadowMapTexture] 2D 4
"ps_3_0
def c19, 7, 0.999989986, 9.99999975e-005, 10
def c20, 0.967999995, 0.0299999993, 0, 0
def c21, 0, 1, 0.5, 0.75
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord4_pp v2.xyz
dcl_texcoord5_pp v3.xyz
dcl_texcoord6 v4
dcl_texcoord8_pp v5.xyz
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
nrm_pp r0.xyz, v2
dp3_pp r1.x, v1, v1
rsq_pp r1.x, r1.x
mul_pp r1.yzw, r1.x, v1.xxyz
texld r2, v0, s2
mul_pp r3.xyz, r2, c15
mov r4, c12
mad_pp r2.xyz, c15, r2, -r4
mad_pp r2.xyz, c16.x, r2, r4
mad_pp r2.w, c16.x, -r4.w, r4.w
mul_pp r3.xyz, r2.w, r3
dp3_pp r3.w, r0, c0
max_pp r4.x, r3.w, c21.x
texldp_pp r5, v4, s4
texld_pp r6, v0, s3
mov r7.xyz, c21
add_pp r3.w, r7.y, -c18.x
mad_pp r3.w, r6.y, c18.x, r3.w
mov r0.w, c21.y
dp4_pp r6.x, c1, r0
dp4_pp r6.y, c2, r0
dp4_pp r6.z, c3, r0
add_pp r4.yzw, r6.xxyz, v3.xxyz
mul_pp r5.xyz, r5.x, c13
dp3 r0.w, r1.yzww, r0
add r0.w, r0.w, r0.w
mad_pp r6.xyz, r0, -r0.w, r1.yzww
if_lt -c6.w, r7.x
nrm_pp r8.xyz, r6
add r9.xyz, c4, -v5
rcp r10.x, r8.x
rcp r10.y, r8.y
rcp r10.z, r8.z
mul_pp r9.xyz, r9, r10
add r11.xyz, c5, -v5
mul_pp r10.xyz, r10, r11
cmp_pp r9.xyz, -r8, r10, r9
min_pp r0.w, r9.y, r9.x
min_pp r5.w, r9.z, r0.w
mov r9.xyz, c5
add r9.xyz, r9, c4
mad r10.xyz, r9, r7.z, -c6
add r10.xyz, r10, v5
mad r8.xyz, r8, r5.w, r10
mad_pp r8.xyz, r9, -c21.z, r8
else
mov_pp r8.xyz, r6
endif
add_pp r0.w, r7.y, -c17.x
pow_pp r5.w, r0.w, c21.w
mul_pp r8.w, r5.w, c19.x
texldl_pp r9, r8, s0
pow_pp r5.w, r9.w, c7.y
mul_pp r5.w, r5.w, c7.x
mul_pp r10.xyz, r9, r5.w
mov r6.w, c5.w
if_lt r6.w, c19.y
if_lt -c10.w, r7.x
nrm_pp r11.xyz, r6
add r12.xyz, c8, -v5
rcp r13.x, r11.x
rcp r13.y, r11.y
rcp r13.z, r11.z
mul_pp r12.xyz, r12, r13
add r14.xyz, c9, -v5
mul_pp r13.xyz, r13, r14
cmp_pp r12.xyz, -r11, r13, r12
min_pp r6.w, r12.y, r12.x
min_pp r7.x, r12.z, r6.w
mov r12.xyz, c8
add r12.xyz, r12, c9
mad r13.xyz, r12, r7.z, -c10
add r13.xyz, r13, v5
mad r7.xzw, r11.xyyz, r7.x, r13.xyyz
mad_pp r8.xyz, r12, -c21.z, r7.xzww
else
mov_pp r8.xyz, r6
endif
texldl_pp r6, r8, s1
pow_pp r7.x, r6.w, c11.y
mul_pp r6.w, r7.x, c11.x
mul_pp r6.xyz, r6, r6.w
mad r7.xzw, r5.w, r9.xyyz, -r6.xyyz
mad_pp r10.xyz, c5.w, r7.xzww, r6
endif
mul_pp r6.xyz, r3.w, r10
mad_pp r7.xzw, v1.xyyz, -r1.x, c0.xyyz
nrm_pp r8.xyz, r7.xzww
dp3_pp r1.x, r0, r8
max_pp r5.w, r1.x, c21.x
dp3_pp r0.x, r0, -r1.yzww
max_pp r1.x, r0.x, c21.x
dp3_pp r0.x, c0, r8
max_pp r1.y, r0.x, c21.x
mul_pp r0.x, r0.w, r0.w
mul_pp r0.y, r0.x, c14.w
mad_pp r0.x, r0.x, -c14.w, r7.y
mad_pp r0.z, r4.x, r0.x, r0.y
mad_pp r0.x, r1.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c19.z
rcp_pp r0.x, r0.x
add_pp r0.y, -r0.w, c21.y
mad_pp r0.y, r0.y, c20.x, c20.y
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c19.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c21.y
mul_pp r0.y, r0.y, c14.y
pow_pp r1.z, r5.w, r0.z
mul_pp r0.y, r0.y, r1.z
add_pp r0.z, -r4.x, c21.y
mul_pp r1.z, r0.z, r0.z
mul_pp r1.z, r1.z, r1.z
mul_pp r0.z, r0.z, r1.z
add_pp r1.x, -r1.x, c21.y
mul_pp r1.z, r1.x, r1.x
mul_pp r1.z, r1.z, r1.z
mul_pp r1.x, r1.x, r1.z
mul_pp r1.z, r1.y, r1.y
dp2add_pp r0.w, r1.z, r0.w, -c21.z
mad_pp r0.z, r0.w, r0.z, c21.y
mad_pp r0.w, r0.w, r1.x, c21.y
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r4.x, r0.x
mul_pp r0.x, r0.x, c14.x
max_pp r1.z, r0.x, c21.x
mul_pp r0.x, r4.x, r0.z
add_pp r0.y, -r2.w, c21.y
add_sat_pp r0.y, r0.y, c17.x
mul_pp r0.xzw, r0.x, r5.xyyz
mad_pp r0.xzw, r4.yyzw, r3.w, r0
mul_pp r4.xyz, r5, r1.z
add_pp r1.y, -r1.y, c21.y
mul_pp r1.z, r1.y, r1.y
mul_pp r1.z, r1.z, r1.z
mul_pp r1.y, r1.y, r1.z
lrp_pp r5.xyz, r1.y, c21.y, r2
mul_pp r1.yzw, r4.xxyz, r5.xxyz
mad_pp r0.xzw, r3.xyyz, r0, r1.yyzw
lrp_pp r3.xyz, r1.x, r0.y, r2
mad_pp oC0.xyz, r6, r3, r0.xzww
mov_pp oC0.w, c21.y

"
}
SubProgram "d3d11 " {
// Stats: 136 math, 3 textures, 4 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_ShadowMapTexture] 2D 4
SetTexture 2 [_OcclusionMap] 2D 3
SetTexture 3 [unity_SpecCube0] CUBE 0
SetTexture 4 [unity_SpecCube1] CUBE 1
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
Float 224 [_OcclusionStrength]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
ConstBuffer "UnityReflectionProbes" 128
Vector 0 [unity_SpecCube0_BoxMax]
Vector 16 [unity_SpecCube0_BoxMin]
Vector 32 [unity_SpecCube0_ProbePosition]
Vector 48 [unity_SpecCube0_HDR]
Vector 64 [unity_SpecCube1_BoxMax]
Vector 80 [unity_SpecCube1_BoxMin]
Vector 96 [unity_SpecCube1_ProbePosition]
Vector 112 [unity_SpecCube1_HDR]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityReflectionProbes" 2
"ps_4_0
eefiecedddnjmfbnhdgalfdohdcdegflfabfdckpabaaaaaamabeaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfibdaaaaeaaaaaaangaeaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaacjaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
lcbabaaaahaaaaaagcbaaaadhcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacanaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahocaabaaaabaaaaaaagaabaaaabaaaaaaagbjbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaa
acaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
kgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaa
dcaaaaanicaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaacaaaaaaegacbaaaadaaaaaabaaaaaaiicaabaaaadaaaaaaegacbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaaaaaoaaaaahdcaabaaaaeaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaaaaaaaaajccaabaaaaeaaaaaaakiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdcaaaaakccaabaaaaeaaaaaa
bkaabaaaafaaaaaaakiacaaaaaaaaaaaaoaaaaaabkaabaaaaeaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaafaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaafaaaaaaegacbaaa
afaaaaaaegbcbaaaagaaaaaadiaaaaaincaabaaaaeaaaaaaagaabaaaaeaaaaaa
agijcaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaajgahbaaaabaaaaaa
egacbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaa
aaaaaaaajgahbaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dkiacaaaacaaaaaaacaaaaaabpaaaeaddkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaaaaaaaaaaegacbaaa
agaaaaaaaaaaaaajhcaabaaaaiaaaaaaegbcbaiaebaaaaaaaiaaaaaaegiccaaa
acaaaaaaaaaaaaaaaoaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaa
ahaaaaaaaaaaaaajhcaabaaaajaaaaaaegbcbaiaebaaaaaaaiaaaaaaegiccaaa
acaaaaaaabaaaaaaaoaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaa
ahaaaaaadbaaaaakhcaabaaaakaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaaaahaaaaaadhaaaaajhcaabaaaaiaaaaaaegacbaaaakaaaaaa
egacbaaaaiaaaaaaegacbaaaajaaaaaaddaaaaahicaabaaaaaaaaaaabkaabaaa
aiaaaaaaakaabaaaaiaaaaaaddaaaaahicaabaaaaaaaaaaackaabaaaaiaaaaaa
dkaabaaaaaaaaaaaaaaaaaajhcaabaaaaiaaaaaaegiccaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaabaaaaaadcaaaaaohcaabaaaajaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegiccaiaebaaaaaaacaaaaaa
acaaaaaaaaaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaaegbcbaaaaiaaaaaa
dcaaaaajhcaabaaaahaaaaaaegacbaaaahaaaaaapgapbaaaaaaaaaaaegacbaaa
ajaaaaaadcaaaaanhcaabaaaahaaaaaaegacbaiaebaaaaaaaiaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaahaaaaaabcaaaaabdgaaaaaf
hcaabaaaahaaaaaaegacbaaaagaaaaaabfaaaaabaaaaaaajicaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpcpaaaaaficaabaaa
afaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaafaaaaaadkaabaaaafaaaaaa
abeaaaaaaaaaeadpbjaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaadiaaaaah
icaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaaaaaaoaeaeiaaaaalpcaabaaa
ahaaaaaaegacbaaaahaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadkaabaaa
afaaaaaacpaaaaaficaabaaaagaaaaaadkaabaaaahaaaaaadiaaaaaiicaabaaa
agaaaaaadkaabaaaagaaaaaabkiacaaaacaaaaaaadaaaaaabjaaaaaficaabaaa
agaaaaaadkaabaaaagaaaaaadiaaaaaiicaabaaaagaaaaaadkaabaaaagaaaaaa
akiacaaaacaaaaaaadaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaahaaaaaa
pgapbaaaagaaaaaadbaaaaaiicaabaaaahaaaaaadkiacaaaacaaaaaaabaaaaaa
abeaaaaafipphpdpbpaaaeaddkaabaaaahaaaaaadbaaaaaiicaabaaaahaaaaaa
abeaaaaaaaaaaaaadkiacaaaacaaaaaaagaaaaaabpaaaeaddkaabaaaahaaaaaa
baaaaaahicaabaaaahaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaaf
icaabaaaahaaaaaadkaabaaaahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaa
agaaaaaapgapbaaaahaaaaaaaaaaaaajhcaabaaaakaaaaaaegbcbaiaebaaaaaa
aiaaaaaaegiccaaaacaaaaaaaeaaaaaaaoaaaaahhcaabaaaakaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaajhcaabaaaalaaaaaaegbcbaiaebaaaaaa
aiaaaaaaegiccaaaacaaaaaaafaaaaaaaoaaaaahhcaabaaaalaaaaaaegacbaaa
alaaaaaaegacbaaaajaaaaaadbaaaaakhcaabaaaamaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaaaajaaaaaadhaaaaajhcaabaaaakaaaaaa
egacbaaaamaaaaaaegacbaaaakaaaaaaegacbaaaalaaaaaaddaaaaahicaabaaa
ahaaaaaabkaabaaaakaaaaaaakaabaaaakaaaaaaddaaaaahicaabaaaahaaaaaa
ckaabaaaakaaaaaadkaabaaaahaaaaaaaaaaaaajhcaabaaaakaaaaaaegiccaaa
acaaaaaaaeaaaaaaegiccaaaacaaaaaaafaaaaaadcaaaaaohcaabaaaalaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegiccaia
ebaaaaaaacaaaaaaagaaaaaaaaaaaaahhcaabaaaalaaaaaaegacbaaaalaaaaaa
egbcbaaaaiaaaaaadcaaaaajhcaabaaaajaaaaaaegacbaaaajaaaaaapgapbaaa
ahaaaaaaegacbaaaalaaaaaadcaaaaanhcaabaaaagaaaaaaegacbaiaebaaaaaa
akaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaajaaaaaa
bfaaaaabeiaaaaalpcaabaaaajaaaaaaegacbaaaagaaaaaaeghobaaaaeaaaaaa
aagabaaaabaaaaaadkaabaaaafaaaaaacpaaaaaficaabaaaafaaaaaadkaabaaa
ajaaaaaadiaaaaaiicaabaaaafaaaaaadkaabaaaafaaaaaabkiacaaaacaaaaaa
ahaaaaaabjaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaadiaaaaaiicaabaaa
afaaaaaadkaabaaaafaaaaaaakiacaaaacaaaaaaahaaaaaadiaaaaahhcaabaaa
agaaaaaaegacbaaaajaaaaaapgapbaaaafaaaaaadcaaaaakhcaabaaaahaaaaaa
pgapbaaaagaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaagaaaaaadcaaaaak
hcaabaaaaiaaaaaapgipcaaaacaaaaaaabaaaaaaegacbaaaahaaaaaaegacbaaa
agaaaaaabfaaaaabdiaaaaahhcaabaaaagaaaaaafgafbaaaaeaaaaaaegacbaaa
aiaaaaaadcaaaaalhcaabaaaahaaaaaaegbcbaiaebaaaaaaacaaaaaaagaabaaa
abaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
ahaaaaaaegacbaaaahaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaahaaaaaaagaabaaaabaaaaaaegacbaaaahaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaahaaaaaadeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaajgahbaiaebaaaaaaabaaaaaabaaaaaaiccaabaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaaegacbaaaahaaaaaadeaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiccaabaaa
abaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaiadpdcaaaaajecaabaaaabaaaaaadkaabaaaadaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaakecaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaaaaaaaaiccaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaa
aaaacaebbkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
bkiacaaaaaaaaaaaaiaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaaiccaabaaaabaaaaaadkaabaiaebaaaaaa
adaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahecaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaakgakbaaa
abaaaaaapgapbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaalpdcaaaaajccaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahmcaabaaaaaaaaaaapgapbaaaadaaaaaakgaobaaa
aaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaa
anaaaaaaaacaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaaagaobaaaaeaaaaaadcaaaaaj
ocaabaaaabaaaaaaagajbaaaafaaaaaafgafbaaaaeaaaaaafgaobaaaabaaaaaa
diaaaaahhcaabaaaaeaaaaaaigadbaaaaeaaaaaakgakbaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaia
ebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaaj
ocaabaaaaaaaaaaaagajbaaaafaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaaeaaaaaadcaaaaaj
ocaabaaaaaaaaaaaagajbaaaadaaaaaafgaobaaaabaaaaaafgaobaaaaaaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaacaaaaaaagaabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaabaaaaaa
jgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 44 avg math (36..48)
 //        d3d9 : 41 avg math (36..45)
 //      opengl : 89 avg math (81..100), 3 avg texture (1..7), 0 avg branch (0..4)
 // Stats for Fragment shader:
 //       d3d11 : 78 avg math (69..90), 3 avg texture (1..7)
 //        d3d9 : 87 avg math (78..99), 3 avg texture (1..7)
 Pass {
  Name "FORWARD_DELTA"
  Tags { "LIGHTMODE"="ForwardAdd" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend [_SrcBlend] One
  GpuProgramID 120105
Program "vp" {
SubProgram "opengl " {
// Stats: 84 math, 2 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(tmpvar_4);
  float tmpvar_6;
  tmpvar_6 = max (0.0, dot (tmpvar_1, tmpvar_5));
  vec3 tmpvar_7;
  tmpvar_7 = (_LightColor0.xyz * texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5))).w);
  vec3 viewDir_8;
  viewDir_8 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_5 + viewDir_8));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_1, viewDir_8));
  float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_5, tmpvar_10));
  float tmpvar_13;
  tmpvar_13 = ((tmpvar_9 * tmpvar_9) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = (10.0 / log2((
    ((1.0 - tmpvar_9) * 0.968)
   + 0.03)));
  tmpvar_14 = (tmpvar_15 * tmpvar_15);
  float x_16;
  x_16 = (1.0 - tmpvar_6);
  float x_17;
  x_17 = (1.0 - tmpvar_11);
  float tmpvar_18;
  tmpvar_18 = (0.5 + ((
    (2.0 * tmpvar_12)
   * tmpvar_12) * tmpvar_9));
  float x_19;
  x_19 = (1.0 - tmpvar_12);
  vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_7 * 
    (((1.0 + (
      (tmpvar_18 - 1.0)
     * 
      ((((x_16 * x_16) * x_16) * x_16) * x_16)
    )) * (1.0 + (
      (tmpvar_18 - 1.0)
     * 
      ((((x_17 * x_17) * x_17) * x_17) * x_17)
    ))) * tmpvar_6)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_6 * (1.0 - tmpvar_13))
       + tmpvar_13) * (
        (tmpvar_11 * (1.0 - tmpvar_13))
       + tmpvar_13)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_10)), tmpvar_14) * ((tmpvar_14 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_6) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_7) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_19 * x_19)
     * x_19) * x_19) * x_19))
  )));
  vec4 xlat_varoutput_21;
  xlat_varoutput_21.xyz = tmpvar_20.xyz;
  xlat_varoutput_21.w = 1.0;
  gl_FragData[0] = xlat_varoutput_21;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_DetailAlbedoMap_ST]
Vector 16 [_MainTex_ST]
Float 18 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c16, c16.zwzw
abs r0.x, c18.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c17.xyxy, c17
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c14
mul r1.xyz, c9, v1.y
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c11, r0
dp4 o6.y, c12, r0
dp4 o6.z, c13, r0
mad r0.xyz, r0, -c15.w, c15
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 44 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedclgbomjjlihicbccdbknfpcnchhppdfgabaaaaaaamajaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcfmahaaaaeaaaabaanhabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaa
aaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 81 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  float tmpvar_5;
  tmpvar_5 = max (0.0, dot (tmpvar_1, tmpvar_4));
  vec3 viewDir_6;
  viewDir_6 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_7;
  tmpvar_7 = (1.0 - _Glossiness);
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_4 + viewDir_6));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_1, viewDir_6));
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_8));
  float tmpvar_11;
  tmpvar_11 = ((tmpvar_7 * tmpvar_7) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = (10.0 / log2((
    ((1.0 - tmpvar_7) * 0.968)
   + 0.03)));
  tmpvar_12 = (tmpvar_13 * tmpvar_13);
  float x_14;
  x_14 = (1.0 - tmpvar_5);
  float x_15;
  x_15 = (1.0 - tmpvar_9);
  float tmpvar_16;
  tmpvar_16 = (0.5 + ((
    (2.0 * tmpvar_10)
   * tmpvar_10) * tmpvar_7));
  float x_17;
  x_17 = (1.0 - tmpvar_10);
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (_LightColor0.xyz * 
    (((1.0 + (
      (tmpvar_16 - 1.0)
     * 
      ((((x_14 * x_14) * x_14) * x_14) * x_14)
    )) * (1.0 + (
      (tmpvar_16 - 1.0)
     * 
      ((((x_15 * x_15) * x_15) * x_15) * x_15)
    ))) * tmpvar_5)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_5 * (1.0 - tmpvar_11))
       + tmpvar_11) * (
        (tmpvar_9 * (1.0 - tmpvar_11))
       + tmpvar_11)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_8)), tmpvar_12) * ((tmpvar_12 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_5) * unity_LightGammaCorrectionConsts.x))
   * _LightColor0.xyz) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_17 * x_17)
     * x_17) * x_17) * x_17))
  )));
  vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = tmpvar_18.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 36 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_DetailAlbedoMap_ST]
Vector 12 [_MainTex_ST]
Float 14 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c12, c12.zwzw
abs r0.x, c14.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c13.xyxy, c13
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c10
mad r0.xyz, r0, -c11.w, c11
mul r1.xyz, c8, v1.y
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 36 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedooclnblejhobpkjgbjmnicahdpmgijmeabaaaaaaliahaaaaadaaaaaa
cmaaaaaaniaaaaaajaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefccaagaaaaeaaaabaaiiabaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaa
acaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaa
akbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
akbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
akbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaa
bkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
bkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
bkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaa
abaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaa
abaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaa
abaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaa
adaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
jgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaaf
hccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaa
abaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaaaaaaaaa
dgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 90 math, 3 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(tmpvar_4);
  float tmpvar_6;
  tmpvar_6 = max (0.0, dot (tmpvar_1, tmpvar_5));
  vec3 tmpvar_7;
  tmpvar_7 = (_LightColor0.xyz * ((
    float((xlv_TEXCOORD5.z > 0.0))
   * texture2D (_LightTexture0, 
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz))).w));
  vec3 viewDir_8;
  viewDir_8 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_5 + viewDir_8));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_1, viewDir_8));
  float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_5, tmpvar_10));
  float tmpvar_13;
  tmpvar_13 = ((tmpvar_9 * tmpvar_9) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = (10.0 / log2((
    ((1.0 - tmpvar_9) * 0.968)
   + 0.03)));
  tmpvar_14 = (tmpvar_15 * tmpvar_15);
  float x_16;
  x_16 = (1.0 - tmpvar_6);
  float x_17;
  x_17 = (1.0 - tmpvar_11);
  float tmpvar_18;
  tmpvar_18 = (0.5 + ((
    (2.0 * tmpvar_12)
   * tmpvar_12) * tmpvar_9));
  float x_19;
  x_19 = (1.0 - tmpvar_12);
  vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_7 * 
    (((1.0 + (
      (tmpvar_18 - 1.0)
     * 
      ((((x_16 * x_16) * x_16) * x_16) * x_16)
    )) * (1.0 + (
      (tmpvar_18 - 1.0)
     * 
      ((((x_17 * x_17) * x_17) * x_17) * x_17)
    ))) * tmpvar_6)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_6 * (1.0 - tmpvar_13))
       + tmpvar_13) * (
        (tmpvar_11 * (1.0 - tmpvar_13))
       + tmpvar_13)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_10)), tmpvar_14) * ((tmpvar_14 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_6) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_7) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_19 * x_19)
     * x_19) * x_19) * x_19))
  )));
  vec4 xlat_varoutput_21;
  xlat_varoutput_21.xyz = tmpvar_20.xyz;
  xlat_varoutput_21.w = 1.0;
  gl_FragData[0] = xlat_varoutput_21;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 8 [_LightMatrix0]
Matrix 4 [_Object2World]
Matrix 12 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 17 [_MainTex_ST]
Float 19 [_UVSec]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c17, c17.zwzw
abs r0.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c15
mul r1.xyz, c13, v1.y
mad r1.xyz, c12, v1.x, r1
mad r1.xyz, c14, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c8, r0
dp4 o6.y, c9, r0
dp4 o6.z, c10, r0
dp4 o6.w, c11, r0
mad r0.xyz, r0, -c16.w, c16
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 44 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedipnadakbbajhidboaideghjlenfcghodabaaaaaaamajaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcfmahaaaaeaaaabaanhabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaa
aaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaaaaaaaaabbaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaabaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 85 math, 3 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(tmpvar_4);
  float tmpvar_6;
  tmpvar_6 = max (0.0, dot (tmpvar_1, tmpvar_5));
  vec3 tmpvar_7;
  tmpvar_7 = (_LightColor0.xyz * (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5))).w * textureCube (_LightTexture0, xlv_TEXCOORD5).w));
  vec3 viewDir_8;
  viewDir_8 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_5 + viewDir_8));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_1, viewDir_8));
  float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_5, tmpvar_10));
  float tmpvar_13;
  tmpvar_13 = ((tmpvar_9 * tmpvar_9) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = (10.0 / log2((
    ((1.0 - tmpvar_9) * 0.968)
   + 0.03)));
  tmpvar_14 = (tmpvar_15 * tmpvar_15);
  float x_16;
  x_16 = (1.0 - tmpvar_6);
  float x_17;
  x_17 = (1.0 - tmpvar_11);
  float tmpvar_18;
  tmpvar_18 = (0.5 + ((
    (2.0 * tmpvar_12)
   * tmpvar_12) * tmpvar_9));
  float x_19;
  x_19 = (1.0 - tmpvar_12);
  vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_7 * 
    (((1.0 + (
      (tmpvar_18 - 1.0)
     * 
      ((((x_16 * x_16) * x_16) * x_16) * x_16)
    )) * (1.0 + (
      (tmpvar_18 - 1.0)
     * 
      ((((x_17 * x_17) * x_17) * x_17) * x_17)
    ))) * tmpvar_6)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_6 * (1.0 - tmpvar_13))
       + tmpvar_13) * (
        (tmpvar_11 * (1.0 - tmpvar_13))
       + tmpvar_13)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_10)), tmpvar_14) * ((tmpvar_14 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_6) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_7) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_19 * x_19)
     * x_19) * x_19) * x_19))
  )));
  vec4 xlat_varoutput_21;
  xlat_varoutput_21.xyz = tmpvar_20.xyz;
  xlat_varoutput_21.w = 1.0;
  gl_FragData[0] = xlat_varoutput_21;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_DetailAlbedoMap_ST]
Vector 16 [_MainTex_ST]
Float 18 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c16, c16.zwzw
abs r0.x, c18.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c17.xyxy, c17
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c14
mul r1.xyz, c9, v1.y
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c11, r0
dp4 o6.y, c12, r0
dp4 o6.z, c13, r0
mad r0.xyz, r0, -c15.w, c15
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 44 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedclgbomjjlihicbccdbknfpcnchhppdfgabaaaaaaamajaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcfmahaaaaeaaaabaanhabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaa
aaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 82 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  float tmpvar_5;
  tmpvar_5 = max (0.0, dot (tmpvar_1, tmpvar_4));
  vec3 tmpvar_6;
  tmpvar_6 = (_LightColor0.xyz * texture2D (_LightTexture0, xlv_TEXCOORD5).w);
  vec3 viewDir_7;
  viewDir_7 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_8;
  tmpvar_8 = (1.0 - _Glossiness);
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_4 + viewDir_7));
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_1, viewDir_7));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_9));
  float tmpvar_12;
  tmpvar_12 = ((tmpvar_8 * tmpvar_8) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = (10.0 / log2((
    ((1.0 - tmpvar_8) * 0.968)
   + 0.03)));
  tmpvar_13 = (tmpvar_14 * tmpvar_14);
  float x_15;
  x_15 = (1.0 - tmpvar_5);
  float x_16;
  x_16 = (1.0 - tmpvar_10);
  float tmpvar_17;
  tmpvar_17 = (0.5 + ((
    (2.0 * tmpvar_11)
   * tmpvar_11) * tmpvar_8));
  float x_18;
  x_18 = (1.0 - tmpvar_11);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_6 * 
    (((1.0 + (
      (tmpvar_17 - 1.0)
     * 
      ((((x_15 * x_15) * x_15) * x_15) * x_15)
    )) * (1.0 + (
      (tmpvar_17 - 1.0)
     * 
      ((((x_16 * x_16) * x_16) * x_16) * x_16)
    ))) * tmpvar_5)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_5 * (1.0 - tmpvar_12))
       + tmpvar_12) * (
        (tmpvar_10 * (1.0 - tmpvar_12))
       + tmpvar_12)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_9)), tmpvar_13) * ((tmpvar_13 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_5) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_18 * x_18)
     * x_18) * x_18) * x_18))
  )));
  vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 39 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 2
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_DetailAlbedoMap_ST]
Vector 15 [_MainTex_ST]
Float 17 [_UVSec]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c15, c15.zwzw
abs r0.x, c17.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c16.xyxy, c16
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c13
mul r1.xyz, c9, v1.y
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c11, r0
dp4 o6.y, c12, r0
mad r0.xyz, r0, -c14.w, c14
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 44 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednpkpccnpenajnhkadfagpnebeklomjihabaaaaaaamajaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcfmahaaaaeaaaabaanhabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaaddccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaa
aaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiacaaaaaaaaaaabbaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaabaaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaa
dcaaaaakdccabaaaagaaaaaaegiacaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaa
egaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 94 math, 4 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform mat4 unity_World2Shadow[4];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25);
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * cse_25);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(tmpvar_4);
  float tmpvar_6;
  tmpvar_6 = max (0.0, dot (tmpvar_1, tmpvar_5));
  vec3 tmpvar_7;
  tmpvar_7 = (_LightColor0.xyz * ((
    (float((xlv_TEXCOORD5.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5)).w)
   * texture2D (_LightTextureB0, vec2(
    dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz)
  )).w) * (_LightShadowData.x + 
    (shadow2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x * (1.0 - _LightShadowData.x))
  )));
  vec3 viewDir_8;
  viewDir_8 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_5 + viewDir_8));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_1, viewDir_8));
  float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_5, tmpvar_10));
  float tmpvar_13;
  tmpvar_13 = ((tmpvar_9 * tmpvar_9) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = (10.0 / log2((
    ((1.0 - tmpvar_9) * 0.968)
   + 0.03)));
  tmpvar_14 = (tmpvar_15 * tmpvar_15);
  float x_16;
  x_16 = (1.0 - tmpvar_6);
  float x_17;
  x_17 = (1.0 - tmpvar_11);
  float tmpvar_18;
  tmpvar_18 = (0.5 + ((
    (2.0 * tmpvar_12)
   * tmpvar_12) * tmpvar_9));
  float x_19;
  x_19 = (1.0 - tmpvar_12);
  vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_7 * 
    (((1.0 + (
      (tmpvar_18 - 1.0)
     * 
      ((((x_16 * x_16) * x_16) * x_16) * x_16)
    )) * (1.0 + (
      (tmpvar_18 - 1.0)
     * 
      ((((x_17 * x_17) * x_17) * x_17) * x_17)
    ))) * tmpvar_6)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_6 * (1.0 - tmpvar_13))
       + tmpvar_13) * (
        (tmpvar_11 * (1.0 - tmpvar_13))
       + tmpvar_13)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_10)), tmpvar_14) * ((tmpvar_14 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_6) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_7) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_19 * x_19)
     * x_19) * x_19) * x_19))
  )));
  vec4 xlat_varoutput_21;
  xlat_varoutput_21.xyz = tmpvar_20.xyz;
  xlat_varoutput_21.w = 1.0;
  gl_FragData[0] = xlat_varoutput_21;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 45 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 12 [_LightMatrix0]
Matrix 8 [_Object2World]
Matrix 16 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Matrix 0 [unity_World2Shadow0]
Vector 22 [_DetailAlbedoMap_ST]
Vector 21 [_MainTex_ST]
Float 23 [_UVSec]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
mad o1.xy, v2, c21, c21.zwzw
abs r0.x, c23.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c22.xyxy, c22
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add o2.xyz, r0, -c19
mul r1.xyz, c17, v1.y
mad r1.xyz, c16, v1.x, r1
mad r1.xyz, c18, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c8, v4
dp3 r1.y, c9, v4
dp3 r1.z, c10, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c11, v0
dp4 o6.x, c12, r0
dp4 o6.y, c13, r0
dp4 o6.z, c14, r0
dp4 o6.w, c15, r0
dp4 o7.x, c0, r0
dp4 o7.y, c1, r0
dp4 o7.z, c2, r0
dp4 o7.w, c3, r0
mad r0.xyz, r0, -c20.w, c20
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 48 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedpgdficnlkjgecflcopjmnkjfmdcilcpcabaaaaaaniajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcbaaiaaaaeaaaabaaaeacaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaaeegiocaaaaeaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaacaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaa
aeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaa
abaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaa
cgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaa
egacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaa
aeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaa
afaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaa
bbaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
bcaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaa
egiocaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaadaaaaaa
alaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 82 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_7 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_7.zw;
  vec3 tmpvar_27;
  tmpvar_27 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_27.x;
  tmpvar_4.w = tmpvar_27.y;
  tmpvar_5.w = tmpvar_27.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  float tmpvar_5;
  tmpvar_5 = max (0.0, dot (tmpvar_1, tmpvar_4));
  vec3 tmpvar_6;
  tmpvar_6 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x);
  vec3 viewDir_7;
  viewDir_7 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_8;
  tmpvar_8 = (1.0 - _Glossiness);
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_4 + viewDir_7));
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_1, viewDir_7));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_9));
  float tmpvar_12;
  tmpvar_12 = ((tmpvar_8 * tmpvar_8) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = (10.0 / log2((
    ((1.0 - tmpvar_8) * 0.968)
   + 0.03)));
  tmpvar_13 = (tmpvar_14 * tmpvar_14);
  float x_15;
  x_15 = (1.0 - tmpvar_5);
  float x_16;
  x_16 = (1.0 - tmpvar_10);
  float tmpvar_17;
  tmpvar_17 = (0.5 + ((
    (2.0 * tmpvar_11)
   * tmpvar_11) * tmpvar_8));
  float x_18;
  x_18 = (1.0 - tmpvar_11);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_6 * 
    (((1.0 + (
      (tmpvar_17 - 1.0)
     * 
      ((((x_15 * x_15) * x_15) * x_15) * x_15)
    )) * (1.0 + (
      (tmpvar_17 - 1.0)
     * 
      ((((x_16 * x_16) * x_16) * x_16) * x_16)
    ))) * tmpvar_5)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_5 * (1.0 - tmpvar_12))
       + tmpvar_12) * (
        (tmpvar_10 * (1.0 - tmpvar_12))
       + tmpvar_12)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_9)), tmpvar_13) * ((tmpvar_13 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_5) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_18 * x_18)
     * x_18) * x_18) * x_18))
  )));
  vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 42 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 15 [_DetailAlbedoMap_ST]
Vector 14 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Float 16 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
"vs_3_0
def c17, 0.5, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
mad o1.xy, v2, c14, c14.zwzw
abs r0.x, c16.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c15.xyxy, c15
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c10
mad r0.xyz, r0, -c13.w, c13
mul r1.xyz, c8, v1.y
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r1.y, c1, v0
mul r0.w, r1.y, c11.x
mul r2.w, r0.w, c17.x
dp4 r1.x, c0, v0
dp4 r1.w, c3, v0
mul r2.xz, r1.xyww, c17.x
mad o6.xy, r2.z, c12.zwzw, r2.xwzw
dp4 r1.z, c2, v0
mov o0, r1
mov o6.zw, r1
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 39 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedfffbenkhkggmkaanphfaegbcnbmopbopabaaaaaagiaiaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcliagaaaaeaaaabaakoabaaaafjaaaaaeegiocaaa
aaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaabaaaaaaagaabaaaabaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaabaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaadaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaaeaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaeaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaeaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaadiaaaaaibcaabaaaaeaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaaeaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaaeaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaaeaaaaaajgaebaaa
acaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaaacaaaaaajgaebaaaadaaaaaa
cgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaadgaaaaafhccabaaaafaaaaaa
egacbaaaadaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaapgbpbaaa
aeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaa
afaaaaaackaabaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 83 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_7 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_7.zw;
  vec3 tmpvar_27;
  tmpvar_27 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_27.x;
  tmpvar_4.w = tmpvar_27.y;
  tmpvar_5.w = tmpvar_27.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD6 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  float tmpvar_5;
  tmpvar_5 = max (0.0, dot (tmpvar_1, tmpvar_4));
  vec3 tmpvar_6;
  tmpvar_6 = (_LightColor0.xyz * (texture2D (_LightTexture0, xlv_TEXCOORD5).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x));
  vec3 viewDir_7;
  viewDir_7 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_8;
  tmpvar_8 = (1.0 - _Glossiness);
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_4 + viewDir_7));
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_1, viewDir_7));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_9));
  float tmpvar_12;
  tmpvar_12 = ((tmpvar_8 * tmpvar_8) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = (10.0 / log2((
    ((1.0 - tmpvar_8) * 0.968)
   + 0.03)));
  tmpvar_13 = (tmpvar_14 * tmpvar_14);
  float x_15;
  x_15 = (1.0 - tmpvar_5);
  float x_16;
  x_16 = (1.0 - tmpvar_10);
  float tmpvar_17;
  tmpvar_17 = (0.5 + ((
    (2.0 * tmpvar_11)
   * tmpvar_11) * tmpvar_8));
  float x_18;
  x_18 = (1.0 - tmpvar_11);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_6 * 
    (((1.0 + (
      (tmpvar_17 - 1.0)
     * 
      ((((x_15 * x_15) * x_15) * x_15) * x_15)
    )) * (1.0 + (
      (tmpvar_17 - 1.0)
     * 
      ((((x_16 * x_16) * x_16) * x_16) * x_16)
    ))) * tmpvar_5)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_5 * (1.0 - tmpvar_12))
       + tmpvar_12) * (
        (tmpvar_10 * (1.0 - tmpvar_12))
       + tmpvar_12)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_9)), tmpvar_13) * ((tmpvar_13 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_5) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_18 * x_18)
     * x_18) * x_18) * x_18))
  )));
  vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 45 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 2
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 17 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Float 19 [_UVSec]
Vector 13 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
"vs_3_0
def c20, 0.5, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.xy
dcl_texcoord6 o7
mad o1.xy, v2, c17, c17.zwzw
abs r0.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c13
mul r1.xyz, c9, v1.y
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c11, r0
dp4 o6.y, c12, r0
mad r0.xyz, r0, -c16.w, c16
dp4 r1.y, c1, v0
mul r0.w, r1.y, c14.x
mul r2.w, r0.w, c20.x
dp4 r1.x, c0, v0
dp4 r1.w, c3, v0
mul r2.xz, r1.xyww, c20.x
mad o7.xy, r2.z, c15.zwzw, r2.xwzw
dp4 r1.z, c2, v0
mov o0, r1
mov o7.zw, r1
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 47 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedjfkabemofiglepikdjaokdlepmpnjnjpabaaaaaalmajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcpeahaaaaeaaaabaapnabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaabiaaaaaibcaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaabaaaaaaagaabaaaabaaaaaaegbabaaaacaaaaaa
egbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaabaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaapgipcaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaafgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadgaaaaaf
hccabaaaadaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaadaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaaeaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaeaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaeaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaadiaaaaaibcaabaaaaeaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaeaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaeaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
adaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaaacaaaaaajgaebaaa
adaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaadaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaa
pgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaf
iccabaaaafaaaaaackaabaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaidcaabaaaacaaaaaafgafbaaaabaaaaaaegiacaaa
aaaaaaaabbaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaabaaaaaaa
agaabaaaabaaaaaaegaabaaaacaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aaaaaaaabcaaaaaakgakbaaaabaaaaaaegaabaaaabaaaaaadcaaaaakdccabaaa
agaaaaaaegiacaaaaaaaaaaabdaaaaaapgapbaaaabaaaaaaegaabaaaabaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 91 math, 3 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25).xyz;
  xlv_TEXCOORD6 = (cse_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD2.w;
  tmpvar_6.y = xlv_TEXCOORD2_1.w;
  tmpvar_6.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (xlv_TEXCOORD6, xlv_TEXCOORD6)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  float tmpvar_10;
  if ((tmpvar_9.x < tmpvar_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  vec3 tmpvar_11;
  tmpvar_11 = normalize(tmpvar_6);
  float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_1, tmpvar_11));
  vec3 tmpvar_13;
  tmpvar_13 = (_LightColor0.xyz * (tmpvar_7.w * tmpvar_10));
  vec3 viewDir_14;
  viewDir_14 = -(tmpvar_2);
  float tmpvar_15;
  tmpvar_15 = (1.0 - _Glossiness);
  vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_11 + viewDir_14));
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_1, viewDir_14));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_11, tmpvar_16));
  float tmpvar_19;
  tmpvar_19 = ((tmpvar_15 * tmpvar_15) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (10.0 / log2((
    ((1.0 - tmpvar_15) * 0.968)
   + 0.03)));
  tmpvar_20 = (tmpvar_21 * tmpvar_21);
  float x_22;
  x_22 = (1.0 - tmpvar_12);
  float x_23;
  x_23 = (1.0 - tmpvar_17);
  float tmpvar_24;
  tmpvar_24 = (0.5 + ((
    (2.0 * tmpvar_18)
   * tmpvar_18) * tmpvar_15));
  float x_25;
  x_25 = (1.0 - tmpvar_18);
  vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = ((tmpvar_4 * (tmpvar_13 * 
    (((1.0 + (
      (tmpvar_24 - 1.0)
     * 
      ((((x_22 * x_22) * x_22) * x_22) * x_22)
    )) * (1.0 + (
      (tmpvar_24 - 1.0)
     * 
      ((((x_23 * x_23) * x_23) * x_23) * x_23)
    ))) * tmpvar_12)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_12 * (1.0 - tmpvar_19))
       + tmpvar_19) * (
        (tmpvar_17 * (1.0 - tmpvar_19))
       + tmpvar_19)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_16)), tmpvar_20) * ((tmpvar_20 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_12) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_13) * (tmpvar_5 + 
    ((1.0 - tmpvar_5) * (((
      (x_25 * x_25)
     * x_25) * x_25) * x_25))
  )));
  vec4 xlat_varoutput_27;
  xlat_varoutput_27.xyz = tmpvar_26.xyz;
  xlat_varoutput_27.w = 1.0;
  gl_FragData[0] = xlat_varoutput_27;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 16 [_LightPositionRange]
Vector 17 [_MainTex_ST]
Float 19 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c17, c17.zwzw
abs r0.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c14
mul r1.xyz, c9, v1.y
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c11, r0
dp4 o6.y, c12, r0
dp4 o6.z, c13, r0
add o7.xyz, r0, -c16
mad r0.xyz, r0, -c15.w, c15
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 45 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcckhbhmdbjkamfbmldplilpddjohkijpabaaaaaafeajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcimahaaaaeaaaabaaodabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaa
agaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaa
diaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaai
bcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaajgaebaaaaaaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaadiaaaaah
hccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaa
aeaaaaaabkaabaaaacaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaabdaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 92 math, 4 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25).xyz;
  xlv_TEXCOORD6 = (cse_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD2.w;
  tmpvar_6.y = xlv_TEXCOORD2_1.w;
  tmpvar_6.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  vec4 tmpvar_8;
  tmpvar_8 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  float tmpvar_9;
  tmpvar_9 = ((sqrt(
    dot (xlv_TEXCOORD6, xlv_TEXCOORD6)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_10;
  tmpvar_10 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_9)) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_6);
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_1, tmpvar_12));
  vec3 tmpvar_14;
  tmpvar_14 = (_LightColor0.xyz * ((tmpvar_7.w * tmpvar_8.w) * tmpvar_11));
  vec3 viewDir_15;
  viewDir_15 = -(tmpvar_2);
  float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_12 + viewDir_15));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_1, viewDir_15));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_12, tmpvar_17));
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_16 * tmpvar_16) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_21;
  float tmpvar_22;
  tmpvar_22 = (10.0 / log2((
    ((1.0 - tmpvar_16) * 0.968)
   + 0.03)));
  tmpvar_21 = (tmpvar_22 * tmpvar_22);
  float x_23;
  x_23 = (1.0 - tmpvar_13);
  float x_24;
  x_24 = (1.0 - tmpvar_18);
  float tmpvar_25;
  tmpvar_25 = (0.5 + ((
    (2.0 * tmpvar_19)
   * tmpvar_19) * tmpvar_16));
  float x_26;
  x_26 = (1.0 - tmpvar_19);
  vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = ((tmpvar_4 * (tmpvar_14 * 
    (((1.0 + (
      (tmpvar_25 - 1.0)
     * 
      ((((x_23 * x_23) * x_23) * x_23) * x_23)
    )) * (1.0 + (
      (tmpvar_25 - 1.0)
     * 
      ((((x_24 * x_24) * x_24) * x_24) * x_24)
    ))) * tmpvar_13)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_13 * (1.0 - tmpvar_20))
       + tmpvar_20) * (
        (tmpvar_18 * (1.0 - tmpvar_20))
       + tmpvar_20)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_17)), tmpvar_21) * ((tmpvar_21 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_13) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_14) * (tmpvar_5 + 
    ((1.0 - tmpvar_5) * (((
      (x_26 * x_26)
     * x_26) * x_26) * x_26))
  )));
  vec4 xlat_varoutput_28;
  xlat_varoutput_28.xyz = tmpvar_27.xyz;
  xlat_varoutput_28.w = 1.0;
  gl_FragData[0] = xlat_varoutput_28;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 16 [_LightPositionRange]
Vector 17 [_MainTex_ST]
Float 19 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c17, c17.zwzw
abs r0.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c14
mul r1.xyz, c9, v1.y
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c11, r0
dp4 o6.y, c12, r0
dp4 o6.z, c13, r0
add o7.xyz, r0, -c16
mad r0.xyz, r0, -c15.w, c15
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 45 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcckhbhmdbjkamfbmldplilpddjohkijpabaaaaaafeajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcimahaaaaeaaaabaaodabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaa
agaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaa
diaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaai
bcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaajgaebaaaaaaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaadiaaaaah
hccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaa
aeaaaaaabkaabaaaacaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaabdaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 100 math, 7 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform mat4 unity_World2Shadow[4];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25);
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * cse_25);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2DShadow _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  vec4 shadows_5;
  vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD6.xyz / xlv_TEXCOORD6.w);
  shadows_5.x = shadow2D (_ShadowMapTexture, (tmpvar_6 + _ShadowOffsets[0].xyz)).x;
  shadows_5.y = shadow2D (_ShadowMapTexture, (tmpvar_6 + _ShadowOffsets[1].xyz)).x;
  shadows_5.z = shadow2D (_ShadowMapTexture, (tmpvar_6 + _ShadowOffsets[2].xyz)).x;
  shadows_5.w = shadow2D (_ShadowMapTexture, (tmpvar_6 + _ShadowOffsets[3].xyz)).x;
  vec4 tmpvar_7;
  tmpvar_7 = (_LightShadowData.xxxx + (shadows_5 * (1.0 - _LightShadowData.xxxx)));
  shadows_5 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(tmpvar_4);
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_1, tmpvar_8));
  vec3 tmpvar_10;
  tmpvar_10 = (_LightColor0.xyz * ((
    (float((xlv_TEXCOORD5.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5)).w)
   * texture2D (_LightTextureB0, vec2(
    dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz)
  )).w) * dot (tmpvar_7, vec4(0.25, 0.25, 0.25, 0.25))));
  vec3 viewDir_11;
  viewDir_11 = -(normalize(xlv_TEXCOORD1));
  float tmpvar_12;
  tmpvar_12 = (1.0 - _Glossiness);
  vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_8 + viewDir_11));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_1, viewDir_11));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_8, tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = ((tmpvar_12 * tmpvar_12) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_17;
  float tmpvar_18;
  tmpvar_18 = (10.0 / log2((
    ((1.0 - tmpvar_12) * 0.968)
   + 0.03)));
  tmpvar_17 = (tmpvar_18 * tmpvar_18);
  float x_19;
  x_19 = (1.0 - tmpvar_9);
  float x_20;
  x_20 = (1.0 - tmpvar_14);
  float tmpvar_21;
  tmpvar_21 = (0.5 + ((
    (2.0 * tmpvar_15)
   * tmpvar_15) * tmpvar_12));
  float x_22;
  x_22 = (1.0 - tmpvar_15);
  vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = (((tmpvar_2 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_10 * 
    (((1.0 + (
      (tmpvar_21 - 1.0)
     * 
      ((((x_19 * x_19) * x_19) * x_19) * x_19)
    )) * (1.0 + (
      (tmpvar_21 - 1.0)
     * 
      ((((x_20 * x_20) * x_20) * x_20) * x_20)
    ))) * tmpvar_9)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_9 * (1.0 - tmpvar_16))
       + tmpvar_16) * (
        (tmpvar_14 * (1.0 - tmpvar_16))
       + tmpvar_16)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_13)), tmpvar_17) * ((tmpvar_17 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_9) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_10) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * (((
      (x_22 * x_22)
     * x_22) * x_22) * x_22))
  )));
  vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 45 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 12 [_LightMatrix0]
Matrix 8 [_Object2World]
Matrix 16 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Matrix 0 [unity_World2Shadow0]
Vector 22 [_DetailAlbedoMap_ST]
Vector 21 [_MainTex_ST]
Float 23 [_UVSec]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
mad o1.xy, v2, c21, c21.zwzw
abs r0.x, c23.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c22.xyxy, c22
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add o2.xyz, r0, -c19
mul r1.xyz, c17, v1.y
mad r1.xyz, c16, v1.x, r1
mad r1.xyz, c18, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c8, v4
dp3 r1.y, c9, v4
dp3 r1.z, c10, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c11, v0
dp4 o6.x, c12, r0
dp4 o6.y, c13, r0
dp4 o6.z, c14, r0
dp4 o6.w, c15, r0
dp4 o7.x, c0, r0
dp4 o7.y, c1, r0
dp4 o7.z, c2, r0
dp4 o7.w, c3, r0
mad r0.xyz, r0, -c20.w, c20
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 48 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 384
Matrix 320 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedahmeongflfcjggajaanpagkhmlpfemffabaaaaaaniajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcbaaiaaaaeaaaabaaaeacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaaeegiocaaaaeaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaacaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaa
aeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaa
abaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaa
cgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaa
egacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaa
aeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaa
afaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaa
bfaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabeaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
bgaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaa
egiocaaaaaaaaaaabhaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaadaaaaaa
alaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 99 math, 6 textures, 4 branches
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25).xyz;
  xlv_TEXCOORD6 = (cse_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD2.w;
  tmpvar_6.y = xlv_TEXCOORD2_1.w;
  tmpvar_6.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  vec4 shadowVals_8;
  shadowVals_8.x = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_8.y = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_8.z = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_8.w = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (shadowVals_8, vec4(((
    sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_10;
  tmpvar_10 = _LightShadowData.xxxx;
  float tmpvar_11;
  if (tmpvar_9.x) {
    tmpvar_11 = tmpvar_10.x;
  } else {
    tmpvar_11 = 1.0;
  };
  float tmpvar_12;
  if (tmpvar_9.y) {
    tmpvar_12 = tmpvar_10.y;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_9.z) {
    tmpvar_13 = tmpvar_10.z;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_9.w) {
    tmpvar_14 = tmpvar_10.w;
  } else {
    tmpvar_14 = 1.0;
  };
  vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_11;
  tmpvar_15.y = tmpvar_12;
  tmpvar_15.z = tmpvar_13;
  tmpvar_15.w = tmpvar_14;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_6);
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_1, tmpvar_16));
  vec3 tmpvar_18;
  tmpvar_18 = (_LightColor0.xyz * (tmpvar_7.w * dot (tmpvar_15, vec4(0.25, 0.25, 0.25, 0.25))));
  vec3 viewDir_19;
  viewDir_19 = -(tmpvar_2);
  float tmpvar_20;
  tmpvar_20 = (1.0 - _Glossiness);
  vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_16 + viewDir_19));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_1, viewDir_19));
  float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_16, tmpvar_21));
  float tmpvar_24;
  tmpvar_24 = ((tmpvar_20 * tmpvar_20) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_25;
  float tmpvar_26;
  tmpvar_26 = (10.0 / log2((
    ((1.0 - tmpvar_20) * 0.968)
   + 0.03)));
  tmpvar_25 = (tmpvar_26 * tmpvar_26);
  float x_27;
  x_27 = (1.0 - tmpvar_17);
  float x_28;
  x_28 = (1.0 - tmpvar_22);
  float tmpvar_29;
  tmpvar_29 = (0.5 + ((
    (2.0 * tmpvar_23)
   * tmpvar_23) * tmpvar_20));
  float x_30;
  x_30 = (1.0 - tmpvar_23);
  vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = ((tmpvar_4 * (tmpvar_18 * 
    (((1.0 + (
      (tmpvar_29 - 1.0)
     * 
      ((((x_27 * x_27) * x_27) * x_27) * x_27)
    )) * (1.0 + (
      (tmpvar_29 - 1.0)
     * 
      ((((x_28 * x_28) * x_28) * x_28) * x_28)
    ))) * tmpvar_17)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_17 * (1.0 - tmpvar_24))
       + tmpvar_24) * (
        (tmpvar_22 * (1.0 - tmpvar_24))
       + tmpvar_24)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_21)), tmpvar_25) * ((tmpvar_25 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_17) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_18) * (tmpvar_5 + 
    ((1.0 - tmpvar_5) * (((
      (x_30 * x_30)
     * x_30) * x_30) * x_30))
  )));
  vec4 xlat_varoutput_32;
  xlat_varoutput_32.xyz = tmpvar_31.xyz;
  xlat_varoutput_32.w = 1.0;
  gl_FragData[0] = xlat_varoutput_32;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 16 [_LightPositionRange]
Vector 17 [_MainTex_ST]
Float 19 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c17, c17.zwzw
abs r0.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c14
mul r1.xyz, c9, v1.y
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c11, r0
dp4 o6.y, c12, r0
dp4 o6.z, c13, r0
add o7.xyz, r0, -c16
mad r0.xyz, r0, -c15.w, c15
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 45 math
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcckhbhmdbjkamfbmldplilpddjohkijpabaaaaaafeajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcimahaaaaeaaaabaaodabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaa
agaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaa
diaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaai
bcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaajgaebaaaaaaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaadiaaaaah
hccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaa
aeaaaaaabkaabaaaacaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaabdaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 100 math, 7 textures, 4 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25).xyz;
  xlv_TEXCOORD6 = (cse_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD2.w;
  tmpvar_6.y = xlv_TEXCOORD2_1.w;
  tmpvar_6.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  vec4 tmpvar_8;
  tmpvar_8 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  vec4 shadowVals_9;
  shadowVals_9.x = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_9.y = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_9.z = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_9.w = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (shadowVals_9, vec4(((
    sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_11;
  tmpvar_11 = _LightShadowData.xxxx;
  float tmpvar_12;
  if (tmpvar_10.x) {
    tmpvar_12 = tmpvar_11.x;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_10.y) {
    tmpvar_13 = tmpvar_11.y;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_10.z) {
    tmpvar_14 = tmpvar_11.z;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_10.w) {
    tmpvar_15 = tmpvar_11.w;
  } else {
    tmpvar_15 = 1.0;
  };
  vec4 tmpvar_16;
  tmpvar_16.x = tmpvar_12;
  tmpvar_16.y = tmpvar_13;
  tmpvar_16.z = tmpvar_14;
  tmpvar_16.w = tmpvar_15;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_6);
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_1, tmpvar_17));
  vec3 tmpvar_19;
  tmpvar_19 = (_LightColor0.xyz * ((tmpvar_7.w * tmpvar_8.w) * dot (tmpvar_16, vec4(0.25, 0.25, 0.25, 0.25))));
  vec3 viewDir_20;
  viewDir_20 = -(tmpvar_2);
  float tmpvar_21;
  tmpvar_21 = (1.0 - _Glossiness);
  vec3 tmpvar_22;
  tmpvar_22 = normalize((tmpvar_17 + viewDir_20));
  float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_1, viewDir_20));
  float tmpvar_24;
  tmpvar_24 = max (0.0, dot (tmpvar_17, tmpvar_22));
  float tmpvar_25;
  tmpvar_25 = ((tmpvar_21 * tmpvar_21) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (10.0 / log2((
    ((1.0 - tmpvar_21) * 0.968)
   + 0.03)));
  tmpvar_26 = (tmpvar_27 * tmpvar_27);
  float x_28;
  x_28 = (1.0 - tmpvar_18);
  float x_29;
  x_29 = (1.0 - tmpvar_23);
  float tmpvar_30;
  tmpvar_30 = (0.5 + ((
    (2.0 * tmpvar_24)
   * tmpvar_24) * tmpvar_21));
  float x_31;
  x_31 = (1.0 - tmpvar_24);
  vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((tmpvar_4 * (tmpvar_19 * 
    (((1.0 + (
      (tmpvar_30 - 1.0)
     * 
      ((((x_28 * x_28) * x_28) * x_28) * x_28)
    )) * (1.0 + (
      (tmpvar_30 - 1.0)
     * 
      ((((x_29 * x_29) * x_29) * x_29) * x_29)
    ))) * tmpvar_18)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_18 * (1.0 - tmpvar_25))
       + tmpvar_25) * (
        (tmpvar_23 * (1.0 - tmpvar_25))
       + tmpvar_25)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_1, tmpvar_22)), tmpvar_26) * ((tmpvar_26 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_18) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_19) * (tmpvar_5 + 
    ((1.0 - tmpvar_5) * (((
      (x_31 * x_31)
     * x_31) * x_31) * x_31))
  )));
  vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = tmpvar_32.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 16 [_LightPositionRange]
Vector 17 [_MainTex_ST]
Float 19 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.xyz
dcl_texcoord6 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c17, c17.zwzw
abs r0.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c14
mul r1.xyz, c9, v1.y
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov o5.xyz, r2
mov o3.xyz, r3
mul o4.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 o6.x, c11, r0
dp4 o6.y, c12, r0
dp4 o6.z, c13, r0
add o7.xyz, r0, -c16
mad r0.xyz, r0, -c15.w, c15
mov o3.w, r0.x
mov o4.w, r0.y
mov o5.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 45 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcckhbhmdbjkamfbmldplilpddjohkijpabaaaaaafeajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcimahaaaaeaaaabaaodabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaa
agaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaa
diaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaai
bcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaajgaebaaaaaaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaadiaaaaah
hccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaa
aeaaaaaabkaabaaaacaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaabdaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 83 math, 2 textures
Keywords { "POINT" "SHADOWS_OFF" }
Vector 3 [_Color]
Float 5 [_Glossiness]
Vector 1 [_LightColor0]
Float 4 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
def c6, 0, 1, 9.99999975e-005, 10
def c7, 0.967999995, 0.0299999993, -0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5.xyz
dcl_2d s0
dcl_2d s1
mov r0.y, c6.y
add_pp r0.x, r0.y, -c5.x
add_pp r0.z, -r0.x, c6.y
mad_pp r0.z, r0.z, c7.x, c7.y
log_pp r0.z, r0.z
rcp r0.z, r0.z
mul_pp r0.z, r0.z, c6.w
mad_pp r0.w, r0.z, r0.z, c6.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.w, r0.w, c2.y
nrm_pp r1.xyz, v1
mov_pp r2.x, v2.w
mov_pp r2.y, v3.w
mov_pp r2.z, v4.w
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
mad_pp r3.xyz, r2, r1.w, -r1
mul_pp r2.xyz, r1.w, r2
nrm_pp r4.xyz, r3
nrm_pp r3.xyz, v4
dp3_pp r1.w, r3, r4
dp3_pp r2.w, r2, r4
dp3_pp r2.x, r3, r2
dp3_pp r1.x, r3, -r1
max_pp r2.y, r1.x, c6.x
max_pp r1.x, r2.x, c6.x
max_pp r1.y, r2.w, c6.x
max_pp r2.x, r1.w, c6.x
pow_pp r1.z, r2.x, r0.z
mul_pp r0.z, r0.w, r1.z
mul_pp r0.w, r0.x, r0.x
mul_pp r1.z, r0.w, c2.w
mad_pp r0.y, r0.w, -c2.w, r0.y
mad_pp r0.w, r2.y, r0.y, r1.z
add_pp r1.w, -r2.y, c6.y
mad_pp r0.y, r1.x, r0.y, r1.z
mad r0.y, r0.y, r0.w, c6.z
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.z, r0.y
mul_pp r0.y, r1.x, r0.y
mul_pp r0.y, r0.y, c2.x
max_pp r1.z, r0.y, c6.x
dp3 r0.y, v5, v5
texld_pp r2, r0.y, s1
mul_pp r0.yzw, r2.x, c1.xxyz
mul_pp r2.xyz, r0.yzww, r1.z
add_pp r1.z, -r1.y, c6.y
mul_pp r1.y, r1.y, r1.y
dp2add_pp r0.x, r1.y, r0.x, c7.z
mul_pp r1.y, r1.z, r1.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.z, r1.y
texld r3, v0, s0
mov r4, c0
mad_pp r5.xyz, c3, r3, -r4
mul_pp r3.xyz, r3, c3
mad_pp r4.xyz, c4.x, r5, r4
lrp_pp r5.xyz, r1.y, c6.y, r4
mul_pp r2.xyz, r2, r5
mul_pp r1.y, r1.w, r1.w
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.w, r1.y
mad_pp r1.y, r0.x, r1.y, c6.y
add_pp r1.z, -r1.x, c6.y
mul_pp r1.w, r1.z, r1.z
mul_pp r1.w, r1.w, r1.w
mul_pp r1.z, r1.z, r1.w
mad_pp r0.x, r0.x, r1.z, c6.y
mul_pp r0.x, r1.y, r0.x
mul_pp r0.x, r1.x, r0.x
mul_pp r0.xyz, r0.x, r0.yzww
mad_pp r0.w, c4.x, -r4.w, r4.w
mul_pp r1.xyz, r0.w, r3
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c6.y

"
}
SubProgram "d3d11 " {
// Stats: 73 math, 2 textures
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmndiijgkhdbnajaamocdimlmiifnffigabaaaaaafaalaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbiakaaaaeaaaaaaaigacaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaa
adaaaaaadgaaaaafccaabaaaabaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaa
abaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaaaaaaaaadeaaaaakgcaabaaaaaaaaaaaagadbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaa
agambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaaaaaacaeb
bkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaa
aaaaaaaaaiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaabkaabaaa
abaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaaj
icaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaabhlhnbdiaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaaiaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaa
efaaaaajpcaabaaaacaaaaaafgafbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaacaaaaaaagijcaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaajgahbaaaabaaaaaa
aaaaaaaljcaabaaaaaaaaaaaagaibaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaakgakbaaaaaaaaaaaagaabaaa
abaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaalp
diaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
aeaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaaadaaaaaaegiccaiaebaaaaaa
aaaaaaaaacaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaalhcaabaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaa
egacbaaaaeaaaaaaegiccaaaaaaaaaaaacaaaaaaaaaaaaalhcaabaaaafaaaaaa
egacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaapgapbaaaaaaaaaaaegacbaaa
aeaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
abaaaaaadcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
dkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 78 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 3 [_Color]
Float 5 [_Glossiness]
Vector 1 [_LightColor0]
Float 4 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
def c6, 0, 1, 9.99999975e-005, 10
def c7, 0.967999995, 0.0299999993, -0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_2d s0
mov r0.y, c6.y
add_pp r0.x, r0.y, -c5.x
add_pp r0.z, -r0.x, c6.y
mad_pp r0.z, r0.z, c7.x, c7.y
log_pp r0.z, r0.z
rcp r0.z, r0.z
mul_pp r0.z, r0.z, c6.w
mad_pp r0.w, r0.z, r0.z, c6.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.w, r0.w, c2.y
dp3_pp r1.x, v1, v1
rsq_pp r1.x, r1.x
mov_pp r2.x, v2.w
mov_pp r2.y, v3.w
mov_pp r2.z, v4.w
mad_pp r1.yzw, v1.xxyz, -r1.x, r2.xxyz
mul_pp r3.xyz, r1.x, v1
nrm_pp r4.xyz, r1.yzww
nrm_pp r1.xyz, v4
dp3_pp r1.w, r1, r4
dp3_pp r2.w, r2, r4
dp3_pp r2.x, r1, r2
dp3_pp r1.x, r1, -r3
max_pp r2.y, r1.x, c6.x
max_pp r1.x, r2.x, c6.x
max_pp r1.y, r2.w, c6.x
max_pp r2.x, r1.w, c6.x
pow_pp r1.z, r2.x, r0.z
mul_pp r0.z, r0.w, r1.z
mul_pp r0.w, r0.x, r0.x
mul_pp r1.z, r0.w, c2.w
mad_pp r0.y, r0.w, -c2.w, r0.y
mad_pp r0.w, r2.y, r0.y, r1.z
add_pp r1.w, -r2.y, c6.y
mad_pp r0.y, r1.x, r0.y, r1.z
mad r0.y, r0.y, r0.w, c6.z
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.z, r0.y
mul_pp r0.y, r1.x, r0.y
mul_pp r0.y, r0.y, c2.x
mul_pp r2.xyz, r0.y, c1
cmp_pp r0.yzw, r0.y, r2.xxyz, c6.x
add_pp r1.z, -r1.y, c6.y
mul_pp r1.y, r1.y, r1.y
dp2add_pp r0.x, r1.y, r0.x, c7.z
mul_pp r1.y, r1.z, r1.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.z, r1.y
texld r2, v0, s0
mov r3, c0
mad_pp r4.xyz, c3, r2, -r3
mul_pp r2.xyz, r2, c3
mad_pp r3.xyz, c4.x, r4, r3
lrp_pp r4.xyz, r1.y, c6.y, r3
mul_pp r0.yzw, r0, r4.xxyz
mul_pp r1.y, r1.w, r1.w
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.w, r1.y
mad_pp r1.y, r0.x, r1.y, c6.y
add_pp r1.z, -r1.x, c6.y
mul_pp r1.w, r1.z, r1.z
mul_pp r1.w, r1.w, r1.w
mul_pp r1.z, r1.z, r1.w
mad_pp r0.x, r0.x, r1.z, c6.y
mul_pp r0.x, r1.y, r0.x
mul_pp r0.x, r1.x, r0.x
mul_pp r1.xyz, r0.x, c1
mad_pp r0.x, c4.x, -r3.w, r3.w
mul_pp r2.xyz, r0.x, r2
mad_pp oC0.xyz, r2, r1, r0.yzww
mov_pp oC0.w, c6.y

"
}
SubProgram "d3d11 " {
// Stats: 69 math, 1 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfkghmfpdnjnbhencdkbkfockgiepfmjgabaaaaaaheakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeajaaaa
eaaaaaaaffacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaa
aeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaaaaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
njmohhdpabeaaaaaipmcpfdmcpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aoaaaaahccaabaaaaaaaaaaaabeaaaaaaaaacaebbkaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaafbcaabaaa
acaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaa
dgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaiaebaaaaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaaeaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadeaaaaakhcaabaaaabaaaaaa
egadbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaabaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
abaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaiadpdcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaabhlhnbdiaoaaaaakecaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaakgakbaaaaaaaaaaaagaabaaa
aaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaalp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamocaabaaa
abaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaaadaaaaaaagijcaiaebaaaaaa
aaaaaaaaacaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaa
fgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaaaaaaaaalhcaabaaaaeaaaaaa
jgahbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dcaaaaajocaabaaaabaaaaaaagajbaaaaeaaaaaafgafbaaaaaaaaaaafgaobaaa
abaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaagaaaaaadcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 87 math, 3 textures
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 3 [_Color]
Float 5 [_Glossiness]
Vector 1 [_LightColor0]
Float 4 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
"ps_3_0
def c6, 0.5, 0, 1, 9.99999975e-005
def c7, 0.967999995, 0.0299999993, 10, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5
dcl_2d s0
dcl_2d s1
dcl_2d s2
mov r0.z, c6.z
add_pp r0.x, r0.z, -c5.x
add_pp r0.y, -r0.x, c6.z
mad_pp r0.y, r0.y, c7.x, c7.y
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c7.z
mad_pp r0.w, r0.y, r0.y, c6.z
mul_pp r0.y, r0.y, r0.y
mul_pp r0.w, r0.w, c2.y
nrm_pp r1.xyz, v1
mov_pp r2.x, v2.w
mov_pp r2.y, v3.w
mov_pp r2.z, v4.w
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
mad_pp r3.xyz, r2, r1.w, -r1
mul_pp r2.xyz, r1.w, r2
nrm_pp r4.xyz, r3
nrm_pp r3.xyz, v4
dp3_pp r1.w, r3, r4
dp3_pp r2.w, r2, r4
dp3_pp r2.x, r3, r2
dp3_pp r1.x, r3, -r1
max_pp r2.y, r1.x, c6.y
max_pp r1.x, r2.x, c6.y
max_pp r1.y, r2.w, c6.y
max_pp r2.x, r1.w, c6.y
pow_pp r1.z, r2.x, r0.y
mul_pp r0.y, r0.w, r1.z
mul_pp r0.w, r0.x, r0.x
mul_pp r1.z, r0.w, c2.w
mad_pp r0.z, r0.w, -c2.w, r0.z
mad_pp r0.w, r2.y, r0.z, r1.z
add_pp r1.w, -r2.y, c6.z
mad_pp r0.z, r1.x, r0.z, r1.z
mad r0.z, r0.z, r0.w, c6.w
rcp_pp r0.z, r0.z
mul_pp r0.y, r0.y, r0.z
mul_pp r0.y, r1.x, r0.y
mul_pp r0.y, r0.y, c2.x
max_pp r1.z, r0.y, c6.y
rcp r0.y, v5.w
mad r0.yz, v5.xxyw, r0.y, c6.x
texld_pp r2, r0.yzzw, s1
dp3 r0.y, v5, v5
texld_pp r3, r0.y, s2
mul r0.y, r2.w, r3.x
mul_pp r0.yzw, r0.y, c1.xxyz
cmp_pp r0.yzw, -v5.z, c6.y, r0
mul_pp r2.xyz, r0.yzww, r1.z
add_pp r1.z, -r1.y, c6.z
mul_pp r1.y, r1.y, r1.y
dp2add_pp r0.x, r1.y, r0.x, -c6.x
mul_pp r1.y, r1.z, r1.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.z, r1.y
texld r3, v0, s0
mov r4, c0
mad_pp r5.xyz, c3, r3, -r4
mul_pp r3.xyz, r3, c3
mad_pp r4.xyz, c4.x, r5, r4
lrp_pp r5.xyz, r1.y, c6.z, r4
mul_pp r2.xyz, r2, r5
mul_pp r1.y, r1.w, r1.w
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.w, r1.y
mad_pp r1.y, r0.x, r1.y, c6.z
add_pp r1.z, -r1.x, c6.z
mul_pp r1.w, r1.z, r1.z
mul_pp r1.w, r1.w, r1.w
mul_pp r1.z, r1.z, r1.w
mad_pp r0.x, r0.x, r1.z, c6.z
mul_pp r0.x, r1.y, r0.x
mul_pp r0.x, r1.x, r0.x
mul_pp r0.xyz, r0.x, r0.yzww
mad_pp r0.w, c4.x, -r4.w, r4.w
mul_pp r1.xyz, r0.w, r3
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c6.z

"
}
SubProgram "d3d11 " {
// Stats: 79 math, 3 textures
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedachcpeibiebjfagmfkndenfkhohmdabpabaaaaaaeeamaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcamalaaaaeaaaaaaamdacaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaaadaaaaaa
dgaaaaafccaabaaaabaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaabaaaaaa
dkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaa
acaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaaaaaaaaadeaaaaakgcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaaaaaacaebbkaabaaa
abaaaaaadiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaabkaabaaaabaaaaaa
dkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajicaabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
ccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
bhlhnbdiaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aoaaaaahgcaabaaaabaaaaaaagbbbaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaak
gcaabaaaabaaaaaafgagbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackbabaaa
agaaaaaaabaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaabkaabaaaabaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaa
acaaaaaakgakbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaaiocaabaaa
abaaaaaafgafbaaaabaaaaaaagijcaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaajgahbaaaabaaaaaaaaaaaaaljcaabaaaaaaaaaaa
agaibaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadp
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaapaaaaah
ecaabaaaaaaaaaaakgakbaaaaaaaaaaaagaabaaaabaaaaaaaaaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaalpdiaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaeaaaaaaegiccaaaaaaaaaaa
ajaaaaaaegacbaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaai
hcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaal
hcaabaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaaeaaaaaaegiccaaa
aaaaaaaaacaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaiaebaaaaaaaeaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaajhcaabaaaaeaaaaaa
egacbaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaabaaaaaadcaaaaanicaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaa
dkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 84 math, 3 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 3 [_Color]
Float 5 [_Glossiness]
Vector 1 [_LightColor0]
Float 4 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] CUBE 1
SetTexture 2 [_LightTextureB0] 2D 2
"ps_3_0
def c6, 0, 1, 9.99999975e-005, 10
def c7, 0.967999995, 0.0299999993, -0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5.xyz
dcl_2d s0
dcl_cube s1
dcl_2d s2
mov r0.y, c6.y
add_pp r0.x, r0.y, -c5.x
add_pp r0.z, -r0.x, c6.y
mad_pp r0.z, r0.z, c7.x, c7.y
log_pp r0.z, r0.z
rcp r0.z, r0.z
mul_pp r0.z, r0.z, c6.w
mad_pp r0.w, r0.z, r0.z, c6.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.w, r0.w, c2.y
nrm_pp r1.xyz, v1
mov_pp r2.x, v2.w
mov_pp r2.y, v3.w
mov_pp r2.z, v4.w
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
mad_pp r3.xyz, r2, r1.w, -r1
mul_pp r2.xyz, r1.w, r2
nrm_pp r4.xyz, r3
nrm_pp r3.xyz, v4
dp3_pp r1.w, r3, r4
dp3_pp r2.w, r2, r4
dp3_pp r2.x, r3, r2
dp3_pp r1.x, r3, -r1
max_pp r2.y, r1.x, c6.x
max_pp r1.x, r2.x, c6.x
max_pp r1.y, r2.w, c6.x
max_pp r2.x, r1.w, c6.x
pow_pp r1.z, r2.x, r0.z
mul_pp r0.z, r0.w, r1.z
mul_pp r0.w, r0.x, r0.x
mul_pp r1.z, r0.w, c2.w
mad_pp r0.y, r0.w, -c2.w, r0.y
mad_pp r0.w, r2.y, r0.y, r1.z
add_pp r1.w, -r2.y, c6.y
mad_pp r0.y, r1.x, r0.y, r1.z
mad r0.y, r0.y, r0.w, c6.z
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.z, r0.y
mul_pp r0.y, r1.x, r0.y
mul_pp r0.y, r0.y, c2.x
max_pp r1.z, r0.y, c6.x
dp3 r0.y, v5, v5
texld r2, r0.y, s2
texld r3, v5, s1
mul_pp r0.y, r2.x, r3.w
mul_pp r0.yzw, r0.y, c1.xxyz
mul_pp r2.xyz, r0.yzww, r1.z
add_pp r1.z, -r1.y, c6.y
mul_pp r1.y, r1.y, r1.y
dp2add_pp r0.x, r1.y, r0.x, c7.z
mul_pp r1.y, r1.z, r1.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.z, r1.y
texld r3, v0, s0
mov r4, c0
mad_pp r5.xyz, c3, r3, -r4
mul_pp r3.xyz, r3, c3
mad_pp r4.xyz, c4.x, r5, r4
lrp_pp r5.xyz, r1.y, c6.y, r4
mul_pp r2.xyz, r2, r5
mul_pp r1.y, r1.w, r1.w
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.w, r1.y
mad_pp r1.y, r0.x, r1.y, c6.y
add_pp r1.z, -r1.x, c6.y
mul_pp r1.w, r1.z, r1.z
mul_pp r1.w, r1.w, r1.w
mul_pp r1.z, r1.z, r1.w
mad_pp r0.x, r0.x, r1.z, c6.y
mul_pp r0.x, r1.y, r0.x
mul_pp r0.x, r1.x, r0.x
mul_pp r0.xyz, r0.x, r0.yzww
mad_pp r0.w, c4.x, -r4.w, r4.w
mul_pp r1.xyz, r0.w, r3
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c6.y

"
}
SubProgram "d3d11 " {
// Stats: 74 math, 3 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTextureB0] 2D 2
SetTexture 2 [_LightTexture0] CUBE 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkoehjbcgmabhieifoomnpkdjgdcbkhhaabaaaaaakmalaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheakaaaaeaaaaaaajnacaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaaadaaaaaa
dgaaaaafccaabaaaabaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaabaaaaaa
dkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaa
acaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaaaaaaaaadeaaaaakgcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaaaaaacaebbkaabaaa
abaaaaaadiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaabkaabaaaabaaaaaa
dkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajicaabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
ccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
bhlhnbdiaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaaj
pcaabaaaacaaaaaafgafbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegbcbaaaagaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaa
diaaaaaiocaabaaaabaaaaaafgafbaaaabaaaaaaagijcaaaaaaaaaaaagaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaajgahbaaaabaaaaaaaaaaaaal
jcaabaaaaaaaaaaaagaibaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaaapaaaaahecaabaaaaaaaaaaakgakbaaaaaaaaaaaagaabaaaabaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaalpdiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaeaaaaaa
egiccaaaaaaaaaaaajaaaaaaegacbaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaalhcaabaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaa
aeaaaaaaegiccaaaaaaaaaaaacaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaia
ebaaaaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaabaaaaaa
dcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 79 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 3 [_Color]
Float 5 [_Glossiness]
Vector 1 [_LightColor0]
Float 4 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
def c6, 0, 1, 9.99999975e-005, 10
def c7, 0.967999995, 0.0299999993, -0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5.xy
dcl_2d s0
dcl_2d s1
mov r0.y, c6.y
add_pp r0.x, r0.y, -c5.x
add_pp r0.z, -r0.x, c6.y
mad_pp r0.z, r0.z, c7.x, c7.y
log_pp r0.z, r0.z
rcp r0.z, r0.z
mul_pp r0.z, r0.z, c6.w
mad_pp r0.w, r0.z, r0.z, c6.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.w, r0.w, c2.y
dp3_pp r1.x, v1, v1
rsq_pp r1.x, r1.x
mov_pp r2.x, v2.w
mov_pp r2.y, v3.w
mov_pp r2.z, v4.w
mad_pp r1.yzw, v1.xxyz, -r1.x, r2.xxyz
mul_pp r3.xyz, r1.x, v1
nrm_pp r4.xyz, r1.yzww
nrm_pp r1.xyz, v4
dp3_pp r1.w, r1, r4
dp3_pp r2.w, r2, r4
dp3_pp r2.x, r1, r2
dp3_pp r1.x, r1, -r3
max_pp r2.y, r1.x, c6.x
max_pp r1.x, r2.x, c6.x
max_pp r1.y, r2.w, c6.x
max_pp r2.x, r1.w, c6.x
pow_pp r1.z, r2.x, r0.z
mul_pp r0.z, r0.w, r1.z
mul_pp r0.w, r0.x, r0.x
mul_pp r1.z, r0.w, c2.w
mad_pp r0.y, r0.w, -c2.w, r0.y
mad_pp r0.w, r2.y, r0.y, r1.z
add_pp r1.w, -r2.y, c6.y
mad_pp r0.y, r1.x, r0.y, r1.z
mad r0.y, r0.y, r0.w, c6.z
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.z, r0.y
mul_pp r0.y, r1.x, r0.y
mul_pp r0.y, r0.y, c2.x
max_pp r1.z, r0.y, c6.x
texld_pp r2, v5, s1
mul_pp r0.yzw, r2.w, c1.xxyz
mul_pp r2.xyz, r0.yzww, r1.z
add_pp r1.z, -r1.y, c6.y
mul_pp r1.y, r1.y, r1.y
dp2add_pp r0.x, r1.y, r0.x, c7.z
mul_pp r1.y, r1.z, r1.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.z, r1.y
texld r3, v0, s0
mov r4, c0
mad_pp r5.xyz, c3, r3, -r4
mul_pp r3.xyz, r3, c3
mad_pp r4.xyz, c4.x, r5, r4
lrp_pp r5.xyz, r1.y, c6.y, r4
mul_pp r2.xyz, r2, r5
mul_pp r1.y, r1.w, r1.w
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.w, r1.y
mad_pp r1.y, r0.x, r1.y, c6.y
add_pp r1.z, -r1.x, c6.y
mul_pp r1.w, r1.z, r1.z
mul_pp r1.w, r1.w, r1.w
mul_pp r1.z, r1.z, r1.w
mad_pp r0.x, r0.x, r1.z, c6.y
mul_pp r0.x, r1.y, r0.x
mul_pp r0.x, r1.x, r0.x
mul_pp r0.xyz, r0.x, r0.yzww
mad_pp r0.w, c4.x, -r4.w, r4.w
mul_pp r1.xyz, r0.w, r3
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c6.y

"
}
SubProgram "d3d11 " {
// Stats: 70 math, 2 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjnogicpmpephdmhjocomoofkmnhonjllabaaaaaapaakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcliajaaaaeaaaaaaagoacaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaaddcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
njmohhdpabeaaaaaipmcpfdmcpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aoaaaaahccaabaaaaaaaaaaaabeaaaaaaaaacaebbkaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaafbcaabaaa
acaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaa
dgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaiaebaaaaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaaeaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadeaaaaakhcaabaaaabaaaaaa
egadbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaabaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
abaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaiadpdcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaabhlhnbdiaoaaaaakecaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaa
acaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaadaaaaaafgafbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaakgakbaaaaaaaaaaaagaabaaa
aaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaalp
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamocaabaaa
abaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaaaeaaaaaaagijcaiaebaaaaaa
aaaaaaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaa
fgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaaaaaaaaalhcaabaaaafaaaaaa
jgahbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dcaaaaajocaabaaaabaaaaaaagajbaaaafaaaaaafgafbaaaaaaaaaaafgaobaaa
abaaaaaadiaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
dkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 90 math, 4 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 4 [_Color]
Float 6 [_Glossiness]
Vector 2 [_LightColor0]
Vector 0 [_LightShadowData]
Float 5 [_Metallic]
Vector 1 [unity_ColorSpaceDielectricSpec]
Vector 3 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_3_0
def c7, 0.5, 0, 1, 9.99999975e-005
def c8, 0.967999995, 0.0299999993, 10, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5
dcl_texcoord6 v6
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
rcp r0.x, v5.w
mad r0.xy, v5, r0.x, c7.x
texld_pp r0, r0, s2
dp3 r0.x, v5, v5
texld_pp r1, r0.x, s3
mul r0.x, r0.w, r1.x
cmp r0.x, -v5.z, c7.y, r0.x
texldp_pp r1, v6, s1
mov r0.z, c7.z
lrp_pp r2.x, r1.x, r0.z, c0.x
mul_pp r0.x, r0.x, r2.x
mul_pp r0.xyw, r0.x, c2.xyzz
add_pp r1.x, r0.z, -c6.x
add_pp r1.y, -r1.x, c7.z
mad_pp r1.y, r1.y, c8.x, c8.y
log_pp r1.y, r1.y
rcp r1.y, r1.y
mul_pp r1.y, r1.y, c8.z
mad_pp r1.z, r1.y, r1.y, c7.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.z, r1.z, c3.y
nrm_pp r2.xyz, v1
mov_pp r3.x, v2.w
mov_pp r3.y, v3.w
mov_pp r3.z, v4.w
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mad_pp r4.xyz, r3, r1.w, -r2
mul_pp r3.xyz, r1.w, r3
nrm_pp r5.xyz, r4
nrm_pp r4.xyz, v4
dp3_pp r1.w, r4, r5
dp3_pp r2.w, r3, r5
dp3_pp r3.x, r4, r3
dp3_pp r2.x, r4, -r2
max_pp r3.y, r2.x, c7.y
max_pp r2.x, r3.x, c7.y
max_pp r3.x, r2.w, c7.y
max_pp r2.y, r1.w, c7.y
pow_pp r3.z, r2.y, r1.y
mul_pp r1.y, r1.z, r3.z
mul_pp r1.z, r1.x, r1.x
mul_pp r1.w, r1.z, c3.w
mad_pp r0.z, r1.z, -c3.w, r0.z
mad_pp r1.z, r3.y, r0.z, r1.w
add_pp r2.y, -r3.y, c7.z
mad_pp r0.z, r2.x, r0.z, r1.w
mad r0.z, r0.z, r1.z, c7.w
rcp_pp r0.z, r0.z
mul_pp r0.z, r1.y, r0.z
mul_pp r0.z, r2.x, r0.z
mul_pp r0.z, r0.z, c3.x
max_pp r1.y, r0.z, c7.y
mul_pp r1.yzw, r0.xxyw, r1.y
add_pp r0.z, -r3.x, c7.z
mul_pp r2.z, r3.x, r3.x
dp2add_pp r1.x, r2.z, r1.x, -c7.x
mul_pp r2.z, r0.z, r0.z
mul_pp r2.z, r2.z, r2.z
mul_pp r0.z, r0.z, r2.z
texld r3, v0, s0
mov r4, c1
mad_pp r5.xyz, c4, r3, -r4
mul_pp r3.xyz, r3, c4
mad_pp r4.xyz, c5.x, r5, r4
lrp_pp r5.xyz, r0.z, c7.z, r4
mul_pp r1.yzw, r1, r5.xxyz
mul_pp r0.z, r2.y, r2.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.z, r2.y, r0.z
mad_pp r0.z, r1.x, r0.z, c7.z
add_pp r2.y, -r2.x, c7.z
mul_pp r2.z, r2.y, r2.y
mul_pp r2.z, r2.z, r2.z
mul_pp r2.y, r2.y, r2.z
mad_pp r1.x, r1.x, r2.y, c7.z
mul_pp r0.z, r0.z, r1.x
mul_pp r0.z, r2.x, r0.z
mul_pp r0.xyz, r0.z, r0.xyww
mad_pp r0.w, c5.x, -r4.w, r4.w
mul_pp r2.xyz, r0.w, r3
mad_pp oC0.xyz, r2, r0, r1.yzww
mov_pp oC0.w, c7.z

"
}
SubProgram "d3d11 " {
// Stats: 85 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [_LightTextureB0] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedmbopaploanjfjkogbmbeffklfemffgkfabaaaaaagianaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbiamaaaaeaaaaaaaagadaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafkaiaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadpcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadbaaaaahbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaaaoaaaaahocaabaaaaaaaaaaaagbjbaaaahaaaaaapgbpbaaa
ahaaaaaaehaaaaalccaabaaaaaaaaaaajgafbaaaaaaaaaaaaghabaaaadaaaaaa
aagabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaaakiacaia
ebaaaaaaabaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaadiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaa
acaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaa
acaaaaaapgapbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
baaaaaaibcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaa
deaaaaahccaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaadeaaaaak
fcaabaaaabaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaahbcaabaaaacaaaaaaabeaaaaa
aaaacaebakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpdiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaacaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaiccaabaaaacaaaaaa
akaabaaaacaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalbcaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadp
dcaaaaajecaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaabkaabaaa
acaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpdcaaaaajbcaabaaaacaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaaa
acaaaaaaabeaaaaabhlhnbdiaoaaaaakbcaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
apaaaaahecaabaaaabaaaaaakgakbaaaabaaaaaapgapbaaaabaaaaaaaaaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaalpdiaaaaahicaabaaa
abaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaeaaaaaaegiccaaa
aaaaaaaaajaaaaaaegacbaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaa
diaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaa
dcaaaaalhcaabaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaaeaaaaaa
egiccaaaaaaaaaaaacaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaiaebaaaaaa
aeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaan
icaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaa
acaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 79 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 3 [_Color]
Float 5 [_Glossiness]
Vector 1 [_LightColor0]
Float 4 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
def c6, 0, 1, 9.99999975e-005, 10
def c7, 0.967999995, 0.0299999993, -0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5
dcl_2d s0
dcl_2d s1
mov r0.y, c6.y
add_pp r0.x, r0.y, -c5.x
add_pp r0.z, -r0.x, c6.y
mad_pp r0.z, r0.z, c7.x, c7.y
log_pp r0.z, r0.z
rcp r0.z, r0.z
mul_pp r0.z, r0.z, c6.w
mad_pp r0.w, r0.z, r0.z, c6.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.w, r0.w, c2.y
dp3_pp r1.x, v1, v1
rsq_pp r1.x, r1.x
mov_pp r2.x, v2.w
mov_pp r2.y, v3.w
mov_pp r2.z, v4.w
mad_pp r1.yzw, v1.xxyz, -r1.x, r2.xxyz
mul_pp r3.xyz, r1.x, v1
nrm_pp r4.xyz, r1.yzww
nrm_pp r1.xyz, v4
dp3_pp r1.w, r1, r4
dp3_pp r2.w, r2, r4
dp3_pp r2.x, r1, r2
dp3_pp r1.x, r1, -r3
max_pp r2.y, r1.x, c6.x
max_pp r1.x, r2.x, c6.x
max_pp r1.y, r2.w, c6.x
max_pp r2.x, r1.w, c6.x
pow_pp r1.z, r2.x, r0.z
mul_pp r0.z, r0.w, r1.z
mul_pp r0.w, r0.x, r0.x
mul_pp r1.z, r0.w, c2.w
mad_pp r0.y, r0.w, -c2.w, r0.y
mad_pp r0.w, r2.y, r0.y, r1.z
add_pp r1.w, -r2.y, c6.y
mad_pp r0.y, r1.x, r0.y, r1.z
mad r0.y, r0.y, r0.w, c6.z
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.z, r0.y
mul_pp r0.y, r1.x, r0.y
mul_pp r0.y, r0.y, c2.x
max_pp r1.z, r0.y, c6.x
texldp_pp r2, v5, s1
mul_pp r0.yzw, r2.x, c1.xxyz
mul_pp r2.xyz, r0.yzww, r1.z
add_pp r1.z, -r1.y, c6.y
mul_pp r1.y, r1.y, r1.y
dp2add_pp r0.x, r1.y, r0.x, c7.z
mul_pp r1.y, r1.z, r1.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.z, r1.y
texld r3, v0, s0
mov r4, c0
mad_pp r5.xyz, c3, r3, -r4
mul_pp r3.xyz, r3, c3
mad_pp r4.xyz, c4.x, r5, r4
lrp_pp r5.xyz, r1.y, c6.y, r4
mul_pp r2.xyz, r2, r5
mul_pp r1.y, r1.w, r1.w
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.w, r1.y
mad_pp r1.y, r0.x, r1.y, c6.y
add_pp r1.z, -r1.x, c6.y
mul_pp r1.w, r1.z, r1.z
mul_pp r1.w, r1.w, r1.w
mul_pp r1.z, r1.z, r1.w
mad_pp r0.x, r0.x, r1.z, c6.y
mul_pp r0.x, r1.y, r0.x
mul_pp r0.x, r1.x, r0.x
mul_pp r0.xyz, r0.x, r0.yzww
mad_pp r0.w, c4.x, -r4.w, r4.w
mul_pp r1.xyz, r0.w, r3
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c6.y

"
}
SubProgram "d3d11 " {
// Stats: 71 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhgjpjpfipbkekgcofflpkaekfjhnhddhabaaaaaaamalaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneajaaaaeaaaaaaahfacaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
njmohhdpabeaaaaaipmcpfdmcpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aoaaaaahccaabaaaaaaaaaaaabeaaaaaaaaacaebbkaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaafbcaabaaa
acaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaa
dgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaiaebaaaaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaaeaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadeaaaaakhcaabaaaabaaaaaa
egadbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaabaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
abaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaiadpdcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaabhlhnbdiaoaaaaakecaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaoaaaaahmcaabaaaabaaaaaaagbebaaaagaaaaaa
pgbpbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaaacaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaadaaaaaafgafbaaaaaaaaaaa
egacbaaaacaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaaapaaaaahbcaabaaaaaaaaaaakgakbaaaaaaaaaaaagaabaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaalpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamocaabaaaabaaaaaa
agijcaaaaaaaaaaaajaaaaaaagajbaaaaeaaaaaaagijcaiaebaaaaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaafgaobaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaaaaaaaaalhcaabaaaafaaaaaajgahbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaaj
ocaabaaaabaaaaaaagajbaaaafaaaaaafgafbaaaaaaaaaaafgaobaaaabaaaaaa
diaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaadaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 80 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 3 [_Color]
Float 5 [_Glossiness]
Vector 1 [_LightColor0]
Float 4 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_3_0
def c6, 0, 1, 9.99999975e-005, 10
def c7, 0.967999995, 0.0299999993, -0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
dcl_2d s0
dcl_2d s1
dcl_2d s2
mov r0.y, c6.y
add_pp r0.x, r0.y, -c5.x
add_pp r0.z, -r0.x, c6.y
mad_pp r0.z, r0.z, c7.x, c7.y
log_pp r0.z, r0.z
rcp r0.z, r0.z
mul_pp r0.z, r0.z, c6.w
mad_pp r0.w, r0.z, r0.z, c6.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.w, r0.w, c2.y
dp3_pp r1.x, v1, v1
rsq_pp r1.x, r1.x
mov_pp r2.x, v2.w
mov_pp r2.y, v3.w
mov_pp r2.z, v4.w
mad_pp r1.yzw, v1.xxyz, -r1.x, r2.xxyz
mul_pp r3.xyz, r1.x, v1
nrm_pp r4.xyz, r1.yzww
nrm_pp r1.xyz, v4
dp3_pp r1.w, r1, r4
dp3_pp r2.w, r2, r4
dp3_pp r2.x, r1, r2
dp3_pp r1.x, r1, -r3
max_pp r2.y, r1.x, c6.x
max_pp r1.x, r2.x, c6.x
max_pp r1.y, r2.w, c6.x
max_pp r2.x, r1.w, c6.x
pow_pp r1.z, r2.x, r0.z
mul_pp r0.z, r0.w, r1.z
mul_pp r0.w, r0.x, r0.x
mul_pp r1.z, r0.w, c2.w
mad_pp r0.y, r0.w, -c2.w, r0.y
mad_pp r0.w, r2.y, r0.y, r1.z
add_pp r1.w, -r2.y, c6.y
mad_pp r0.y, r1.x, r0.y, r1.z
mad r0.y, r0.y, r0.w, c6.z
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.z, r0.y
mul_pp r0.y, r1.x, r0.y
mul_pp r0.y, r0.y, c2.x
max_pp r1.z, r0.y, c6.x
texld r2, v5, s2
texldp_pp r3, v6, s1
mul_pp r0.y, r2.w, r3.x
mul_pp r0.yzw, r0.y, c1.xxyz
mul_pp r2.xyz, r0.yzww, r1.z
add_pp r1.z, -r1.y, c6.y
mul_pp r1.y, r1.y, r1.y
dp2add_pp r0.x, r1.y, r0.x, c7.z
mul_pp r1.y, r1.z, r1.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.z, r1.y
texld r3, v0, s0
mov r4, c0
mad_pp r5.xyz, c3, r3, -r4
mul_pp r3.xyz, r3, c3
mad_pp r4.xyz, c4.x, r5, r4
lrp_pp r5.xyz, r1.y, c6.y, r4
mul_pp r2.xyz, r2, r5
mul_pp r1.y, r1.w, r1.w
mul_pp r1.y, r1.y, r1.y
mul_pp r1.y, r1.w, r1.y
mad_pp r1.y, r0.x, r1.y, c6.y
add_pp r1.z, -r1.x, c6.y
mul_pp r1.w, r1.z, r1.z
mul_pp r1.w, r1.w, r1.w
mul_pp r1.z, r1.z, r1.w
mad_pp r0.x, r0.x, r1.z, c6.y
mul_pp r0.x, r1.y, r0.x
mul_pp r0.x, r1.x, r0.x
mul_pp r0.xyz, r0.x, r0.yzww
mad_pp r0.w, c4.x, -r4.w, r4.w
mul_pp r1.xyz, r0.w, r3
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c6.y

"
}
SubProgram "d3d11 " {
// Stats: 72 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjpoljlhcfmflfnbehoflmninhkpjficoabaaaaaaimalaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdmakaaaaeaaaaaaaipacaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaa
gcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaaddcbabaaa
agaaaaaagcbaaaadlcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaajbcaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
njmohhdpabeaaaaaipmcpfdmcpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aoaaaaahccaabaaaaaaaaaaaabeaaaaaaaaacaebbkaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaafbcaabaaa
acaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaa
dgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaiaebaaaaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaaeaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadeaaaaakhcaabaaaabaaaaaa
egadbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaabaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
abaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaiadpdcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaabhlhnbdiaoaaaaakecaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaoaaaaahmcaabaaaabaaaaaaagbebaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaa
acaaaaaadkaabaaaadaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaadaaaaaafgafbaaaaaaaaaaa
egacbaaaacaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaaapaaaaahbcaabaaaaaaaaaaakgakbaaaaaaaaaaaagaabaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaalpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamocaabaaaabaaaaaa
agijcaaaaaaaaaaaajaaaaaaagajbaaaaeaaaaaaagijcaiaebaaaaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaafgaobaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaaaaaaaaalhcaabaaaafaaaaaajgahbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaaj
ocaabaaaabaaaaaaagajbaaaafaaaaaafgafbaaaaaaaaaaafgaobaaaabaaaaaa
diaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaadaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 90 math, 3 textures
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 5 [_Color]
Float 7 [_Glossiness]
Vector 3 [_LightColor0]
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Float 6 [_Metallic]
Vector 2 [unity_ColorSpaceDielectricSpec]
Vector 4 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] CUBE 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_3_0
def c8, 0.970000029, 1, 0, 9.99999975e-005
def c9, 0.967999995, 0.0299999993, 10, -0.5
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_2d s0
dcl_cube s1
dcl_2d s2
dp3 r0.x, v6, v6
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0.x, c0.w
texld r1, v6, s1
mad r0.x, r0.x, -c8.x, r1.x
mov r0.y, c8.y
cmp_pp r0.x, r0.x, r0.y, c1.x
dp3 r0.z, v5, v5
texld r1, r0.z, s2
mul_pp r0.x, r0.x, r1.x
mul_pp r0.xzw, r0.x, c3.xyyz
add_pp r1.x, r0.y, -c7.x
add_pp r1.y, -r1.x, c8.y
mad_pp r1.y, r1.y, c9.x, c9.y
log_pp r1.y, r1.y
rcp r1.y, r1.y
mul_pp r1.y, r1.y, c9.z
mad_pp r1.z, r1.y, r1.y, c8.y
mul_pp r1.y, r1.y, r1.y
mul_pp r1.z, r1.z, c4.y
nrm_pp r2.xyz, v1
mov_pp r3.x, v2.w
mov_pp r3.y, v3.w
mov_pp r3.z, v4.w
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mad_pp r4.xyz, r3, r1.w, -r2
mul_pp r3.xyz, r1.w, r3
nrm_pp r5.xyz, r4
nrm_pp r4.xyz, v4
dp3_pp r1.w, r4, r5
dp3_pp r2.w, r3, r5
dp3_pp r3.x, r4, r3
dp3_pp r2.x, r4, -r2
max_pp r3.y, r2.x, c8.z
max_pp r2.x, r3.x, c8.z
max_pp r3.x, r2.w, c8.z
max_pp r2.y, r1.w, c8.z
pow_pp r3.z, r2.y, r1.y
mul_pp r1.y, r1.z, r3.z
mul_pp r1.z, r1.x, r1.x
mul_pp r1.w, r1.z, c4.w
mad_pp r0.y, r1.z, -c4.w, r0.y
mad_pp r1.z, r3.y, r0.y, r1.w
add_pp r2.y, -r3.y, c8.y
mad_pp r0.y, r2.x, r0.y, r1.w
mad r0.y, r0.y, r1.z, c8.w
rcp_pp r0.y, r0.y
mul_pp r0.y, r1.y, r0.y
mul_pp r0.y, r2.x, r0.y
mul_pp r0.y, r0.y, c4.x
max_pp r1.y, r0.y, c8.z
mul_pp r1.yzw, r0.xxzw, r1.y
add_pp r0.y, -r3.x, c8.y
mul_pp r2.z, r3.x, r3.x
dp2add_pp r1.x, r2.z, r1.x, c9.w
mul_pp r2.z, r0.y, r0.y
mul_pp r2.z, r2.z, r2.z
mul_pp r0.y, r0.y, r2.z
texld r3, v0, s0
mov r4, c2
mad_pp r5.xyz, c5, r3, -r4
mul_pp r3.xyz, r3, c5
mad_pp r4.xyz, c6.x, r5, r4
lrp_pp r5.xyz, r0.y, c8.y, r4
mul_pp r1.yzw, r1, r5.xxyz
mul_pp r0.y, r2.y, r2.y
mul_pp r0.y, r0.y, r0.y
mul_pp r0.y, r2.y, r0.y
mad_pp r0.y, r1.x, r0.y, c8.y
add_pp r2.y, -r2.x, c8.y
mul_pp r2.z, r2.y, r2.y
mul_pp r2.z, r2.z, r2.z
mul_pp r2.y, r2.y, r2.z
mad_pp r1.x, r1.x, r2.y, c8.y
mul_pp r0.y, r0.y, r1.x
mul_pp r0.y, r2.x, r0.y
mul_pp r0.xyz, r0.y, r0.xzww
mad_pp r0.w, c6.x, -r4.w, r4.w
mul_pp r2.xyz, r0.w, r3
mad_pp oC0.xyz, r2, r0, r1.yzww
mov_pp oC0.w, c8.y

"
}
SubProgram "d3d11 " {
// Stats: 79 math, 3 textures
Keywords { "POINT" "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [_ShadowMapTexture] CUBE 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedlhlnbnncoiobklbkidaongfocfjdhfebabaaaaaakaamaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaalaaaaeaaaaaaaneacaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaa
gcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaa
adaaaaaadgaaaaafccaabaaaabaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaa
abaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaaaaaaaaadeaaaaakgcaabaaaaaaaaaaaagadbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaa
agambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaaaaaacaeb
bkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaa
aaaaaaaaaiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaabkaabaaa
abaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaaj
icaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaabhlhnbdiaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaaiaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaa
elaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
bkaabaaaabaaaaaadkiacaaaabaaaaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaomfbhidpefaaaaajpcaabaaaacaaaaaaegbcbaaa
ahaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadbaaaaahccaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaaaabaaaaaadhaaaaakccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaa
abaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaa
kgakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaaiocaabaaaabaaaaaa
fgafbaaaabaaaaaaagijcaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaajgahbaaaabaaaaaaaaaaaaaljcaabaaaaaaaaaaaagaibaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaapaaaaahecaabaaa
aaaaaaaakgakbaaaaaaaaaaaagaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaalpdiaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaaeaaaaaaegiccaaaaaaaaaaaajaaaaaa
egacbaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaa
aeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
acaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaabaaaaaadcaaaaanicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 91 math, 4 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 5 [_Color]
Float 7 [_Glossiness]
Vector 3 [_LightColor0]
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Float 6 [_Metallic]
Vector 2 [unity_ColorSpaceDielectricSpec]
Vector 4 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] CUBE 1
SetTexture 2 [_LightTexture0] CUBE 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_3_0
def c8, 0.970000029, 1, 0, 9.99999975e-005
def c9, 0.967999995, 0.0299999993, 10, -0.5
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_2d s0
dcl_cube s1
dcl_cube s2
dcl_2d s3
dp3 r0.x, v6, v6
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0.x, c0.w
texld r1, v6, s1
mad r0.x, r0.x, -c8.x, r1.x
mov r0.y, c8.y
cmp_pp r0.x, r0.x, r0.y, c1.x
dp3 r0.z, v5, v5
texld r1, r0.z, s3
texld r2, v5, s2
mul r0.z, r1.x, r2.w
mul_pp r0.x, r0.x, r0.z
mul_pp r0.xzw, r0.x, c3.xyyz
add_pp r1.x, r0.y, -c7.x
add_pp r1.y, -r1.x, c8.y
mad_pp r1.y, r1.y, c9.x, c9.y
log_pp r1.y, r1.y
rcp r1.y, r1.y
mul_pp r1.y, r1.y, c9.z
mad_pp r1.z, r1.y, r1.y, c8.y
mul_pp r1.y, r1.y, r1.y
mul_pp r1.z, r1.z, c4.y
nrm_pp r2.xyz, v1
mov_pp r3.x, v2.w
mov_pp r3.y, v3.w
mov_pp r3.z, v4.w
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mad_pp r4.xyz, r3, r1.w, -r2
mul_pp r3.xyz, r1.w, r3
nrm_pp r5.xyz, r4
nrm_pp r4.xyz, v4
dp3_pp r1.w, r4, r5
dp3_pp r2.w, r3, r5
dp3_pp r3.x, r4, r3
dp3_pp r2.x, r4, -r2
max_pp r3.y, r2.x, c8.z
max_pp r2.x, r3.x, c8.z
max_pp r3.x, r2.w, c8.z
max_pp r2.y, r1.w, c8.z
pow_pp r3.z, r2.y, r1.y
mul_pp r1.y, r1.z, r3.z
mul_pp r1.z, r1.x, r1.x
mul_pp r1.w, r1.z, c4.w
mad_pp r0.y, r1.z, -c4.w, r0.y
mad_pp r1.z, r3.y, r0.y, r1.w
add_pp r2.y, -r3.y, c8.y
mad_pp r0.y, r2.x, r0.y, r1.w
mad r0.y, r0.y, r1.z, c8.w
rcp_pp r0.y, r0.y
mul_pp r0.y, r1.y, r0.y
mul_pp r0.y, r2.x, r0.y
mul_pp r0.y, r0.y, c4.x
max_pp r1.y, r0.y, c8.z
mul_pp r1.yzw, r0.xxzw, r1.y
add_pp r0.y, -r3.x, c8.y
mul_pp r2.z, r3.x, r3.x
dp2add_pp r1.x, r2.z, r1.x, c9.w
mul_pp r2.z, r0.y, r0.y
mul_pp r2.z, r2.z, r2.z
mul_pp r0.y, r0.y, r2.z
texld r3, v0, s0
mov r4, c2
mad_pp r5.xyz, c5, r3, -r4
mul_pp r3.xyz, r3, c5
mad_pp r4.xyz, c6.x, r5, r4
lrp_pp r5.xyz, r0.y, c8.y, r4
mul_pp r1.yzw, r1, r5.xxyz
mul_pp r0.y, r2.y, r2.y
mul_pp r0.y, r0.y, r0.y
mul_pp r0.y, r2.y, r0.y
mad_pp r0.y, r1.x, r0.y, c8.y
add_pp r2.y, -r2.x, c8.y
mul_pp r2.z, r2.y, r2.y
mul_pp r2.z, r2.z, r2.z
mul_pp r2.y, r2.y, r2.z
mad_pp r1.x, r1.x, r2.y, c8.y
mul_pp r0.y, r0.y, r1.x
mul_pp r0.y, r2.x, r0.y
mul_pp r0.xyz, r0.y, r0.xzww
mad_pp r0.w, c6.x, -r4.w, r4.w
mul_pp r2.xyz, r0.w, r3
mad_pp oC0.xyz, r2, r0, r1.yzww
mov_pp oC0.w, c8.y

"
}
SubProgram "d3d11 " {
// Stats: 82 math, 4 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTextureB0] 2D 3
SetTexture 2 [_LightTexture0] CUBE 2
SetTexture 3 [_ShadowMapTexture] CUBE 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedmbghekbnlllbhhgddhboonmecafcjclkabaaaaaacaanaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcnaalaaaaeaaaaaaapeacaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaa
acaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaad
icbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaomfbhidpefaaaaajpcaabaaaabaaaaaaegbcbaaaahaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egbcbaaaagaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadgaaaaaf
bcaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaa
aeaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaapgapbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahccaabaaa
abaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaadeaaaaakfcaabaaaabaaaaaa
agadbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaaaoaaaaahbcaabaaaacaaaaaaabeaaaaaaaaacaebakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaaiccaabaaaacaaaaaaakaabaaaacaaaaaa
dkiacaaaaaaaaaaaaiaaaaaadcaaaaalbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaa
acaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaacaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
bhlhnbdiaoaaaaakbcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaaapaaaaahecaabaaa
abaaaaaakgakbaaaabaaaaaapgapbaaaabaaaaaaaaaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaalpdiaaaaahicaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaaeaaaaaaegiccaaaaaaaaaaaajaaaaaa
egacbaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaa
aeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
acaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaanicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 99 math, 7 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 8 [_Color]
Float 10 [_Glossiness]
Vector 6 [_LightColor0]
Vector 4 [_LightShadowData]
Float 9 [_Metallic]
Vector 0 [_ShadowOffsets0]
Vector 1 [_ShadowOffsets1]
Vector 2 [_ShadowOffsets2]
Vector 3 [_ShadowOffsets3]
Vector 5 [unity_ColorSpaceDielectricSpec]
Vector 7 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_3_0
def c11, 0.5, 0, 1, 0.25
def c12, 9.99999975e-005, 0.967999995, 0.0299999993, 10
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5
dcl_texcoord6 v6
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
mov r0.z, c11.z
rcp r0.x, v6.w
mad r1, v6, r0.x, c0
texldp_pp r1, r1, s1
mad r2, v6, r0.x, c1
texldp_pp r2, r2, s1
mov_pp r1.y, r2.x
mad r2, v6, r0.x, c2
mad r3, v6, r0.x, c3
texldp_pp r3, r3, s1
mov_pp r1.w, r3.x
texldp_pp r2, r2, s1
mov_pp r1.z, r2.x
lrp_pp r2, r1, r0.z, c4.x
dp4_pp r0.x, r2, c11.w
rcp r0.y, v5.w
mad r0.yw, v5.xxzy, r0.y, c11.x
texld_pp r1, r0.ywzw, s2
dp3 r0.y, v5, v5
texld_pp r2, r0.y, s3
mul r0.y, r1.w, r2.x
cmp r0.y, -v5.z, c11.y, r0.y
mul_pp r0.x, r0.x, r0.y
mul_pp r0.xyw, r0.x, c6.xyzz
add_pp r1.x, r0.z, -c10.x
add_pp r1.y, -r1.x, c11.z
mad_pp r1.y, r1.y, c12.y, c12.z
log_pp r1.y, r1.y
rcp r1.y, r1.y
mul_pp r1.y, r1.y, c12.w
mad_pp r1.z, r1.y, r1.y, c11.z
mul_pp r1.y, r1.y, r1.y
mul_pp r1.z, r1.z, c7.y
nrm_pp r2.xyz, v1
mov_pp r3.x, v2.w
mov_pp r3.y, v3.w
mov_pp r3.z, v4.w
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mad_pp r4.xyz, r3, r1.w, -r2
mul_pp r3.xyz, r1.w, r3
nrm_pp r5.xyz, r4
nrm_pp r4.xyz, v4
dp3_pp r1.w, r4, r5
dp3_pp r2.w, r3, r5
dp3_pp r3.x, r4, r3
dp3_pp r2.x, r4, -r2
max_pp r3.y, r2.x, c11.y
max_pp r2.x, r3.x, c11.y
max_pp r3.x, r2.w, c11.y
max_pp r2.y, r1.w, c11.y
pow_pp r3.z, r2.y, r1.y
mul_pp r1.y, r1.z, r3.z
mul_pp r1.z, r1.x, r1.x
mul_pp r1.w, r1.z, c7.w
mad_pp r0.z, r1.z, -c7.w, r0.z
mad_pp r1.z, r3.y, r0.z, r1.w
add_pp r2.y, -r3.y, c11.z
mad_pp r0.z, r2.x, r0.z, r1.w
mad r0.z, r0.z, r1.z, c12.x
rcp_pp r0.z, r0.z
mul_pp r0.z, r1.y, r0.z
mul_pp r0.z, r2.x, r0.z
mul_pp r0.z, r0.z, c7.x
max_pp r1.y, r0.z, c11.y
mul_pp r1.yzw, r0.xxyw, r1.y
add_pp r0.z, -r3.x, c11.z
mul_pp r2.z, r3.x, r3.x
dp2add_pp r1.x, r2.z, r1.x, -c11.x
mul_pp r2.z, r0.z, r0.z
mul_pp r2.z, r2.z, r2.z
mul_pp r0.z, r0.z, r2.z
texld r3, v0, s0
mov r4, c5
mad_pp r5.xyz, c8, r3, -r4
mul_pp r3.xyz, r3, c8
mad_pp r4.xyz, c9.x, r5, r4
lrp_pp r5.xyz, r0.z, c11.z, r4
mul_pp r1.yzw, r1, r5.xxyz
mul_pp r0.z, r2.y, r2.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.z, r2.y, r0.z
mad_pp r0.z, r1.x, r0.z, c11.z
add_pp r2.y, -r2.x, c11.z
mul_pp r2.z, r2.y, r2.y
mul_pp r2.z, r2.z, r2.z
mul_pp r2.y, r2.y, r2.z
mad_pp r1.x, r1.x, r2.y, c11.z
mul_pp r0.z, r0.z, r1.x
mul_pp r0.z, r2.x, r0.z
mul_pp r0.xyz, r0.z, r0.xyww
mad_pp r0.w, c9.x, -r4.w, r4.w
mul_pp r2.xyz, r0.w, r3
mad_pp oC0.xyz, r2, r0, r1.yzww
mov_pp oC0.w, c11.z

"
}
SubProgram "d3d11 " {
// Stats: 90 math, 3 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [_LightTextureB0] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 1
ConstBuffer "$Globals" 384
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
Vector 256 [_ShadowOffsets0]
Vector 272 [_ShadowOffsets1]
Vector 288 [_ShadowOffsets2]
Vector 304 [_ShadowOffsets3]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedniipodmehifedjjmdhnfbbphpnkogclpabaaaaaajeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceeanaaaaeaaaaaaafbadaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafkaiaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadpcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaia
ebaaaaaaabaaaaaabiaaaaaaabeaaaaaaaaaiadpaoaaaaahocaabaaaaaaaaaaa
agbjbaaaahaaaaaapgbpbaaaahaaaaaaaaaaaaaihcaabaaaabaaaaaajgahbaaa
aaaaaaaaegiccaaaaaaaaaaabaaaaaaaehaaaaalbcaabaaaabaaaaaaegaabaaa
abaaaaaaaghabaaaadaaaaaaaagabaaaabaaaaaackaabaaaabaaaaaaaaaaaaai
hcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaaehaaaaal
ccaabaaaabaaaaaaegaabaaaacaaaaaaaghabaaaadaaaaaaaagabaaaabaaaaaa
ckaabaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaa
aaaaaaaabcaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaa
aaaaaaaabdaaaaaaehaaaaalicaabaaaabaaaaaajgafbaaaaaaaaaaaaghabaaa
adaaaaaaaagabaaaabaaaaaadkaabaaaaaaaaaaaehaaaaalecaabaaaabaaaaaa
egaabaaaacaaaaaaaghabaaaadaaaaaaaagabaaaabaaaaaackaabaaaacaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaaagiacaaa
abaaaaaabiaaaaaabbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaiadoaaaaiadoaaaaiadoaaaaiadoaoaaaaahgcaabaaaaaaaaaaaagbbbaaa
agaaaaaapgbpbaaaagaaaaaaaaaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaaabaaaaaa
jgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadbaaaaahccaabaaa
aaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaadkaabaaa
abaaaaaabkaabaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegbcbaaaacaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaa
adaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaa
acaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaadaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaiaebaaaaaaabaaaaaadeaaaaahccaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaaaaaaaaaadeaaaaakfcaabaaaabaaaaaaagadbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpdcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaanjmohhdp
abeaaaaaipmcpfdmcpaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaah
bcaabaaaacaaaaaaabeaaaaaaaaacaebakaabaaaacaaaaaadiaaaaahccaabaaa
acaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaaiccaabaaaacaaaaaaakaabaaaacaaaaaadkiacaaaaaaaaaaaaiaaaaaa
dcaaaaalbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaa
aiaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaaacaaaaaaakaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaacaaaaaabkaabaaa
abaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaabhlhnbdiaoaaaaakbcaabaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaacaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaabaaaaaaapaaaaahecaabaaaabaaaaaakgakbaaaabaaaaaa
pgapbaaaabaaaaaaaaaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaalpdiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaaeaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaaadaaaaaaegiccaia
ebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaaaeaaaaaakgikcaaaaaaaaaaa
anaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaacaaaaaaaaaaaaalhcaabaaa
afaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaapgapbaaaaaaaaaaa
egacbaaaaeaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
bcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 98 math, 6 textures
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 5 [_Color]
Float 7 [_Glossiness]
Vector 3 [_LightColor0]
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Float 6 [_Metallic]
Vector 2 [unity_ColorSpaceDielectricSpec]
Vector 4 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] CUBE 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_3_0
def c8, 0.0078125, -0.0078125, 0.970000029, 1
def c9, 0.25, 0, 9.99999975e-005, 10
def c10, 0.967999995, 0.0299999993, -0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_2d s0
dcl_cube s1
dcl_2d s2
dp3 r0.x, v6, v6
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0.x, c0.w
add r0.yzw, c8.x, v6.xxyz
texld r1, r0.yzww, s1
add r0.yzw, c8.xyyx, v6.xxyz
texld r2, r0.yzww, s1
mov r1.y, r2.x
add r0.yzw, c8.xyxy, v6.xxyz
texld r2, r0.yzww, s1
mov r1.z, r2.x
add r0.yzw, c8.xxyy, v6.xxyz
texld r2, r0.yzww, s1
mov r1.w, r2.x
mad r0, r0.x, -c8.z, r1
mov r1.w, c8.w
cmp_pp r0, r0, r1.w, c1.x
dp4_pp r0.x, r0, c9.x
dp3 r0.y, v5, v5
texld r2, r0.y, s2
mul_pp r0.x, r0.x, r2.x
mul_pp r0.xyz, r0.x, c3
add_pp r0.w, r1.w, -c7.x
add_pp r1.x, -r0.w, c8.w
mad_pp r1.x, r1.x, c10.x, c10.y
log_pp r1.x, r1.x
rcp r1.x, r1.x
mul_pp r1.x, r1.x, c9.w
mad_pp r1.y, r1.x, r1.x, c8.w
mul_pp r1.x, r1.x, r1.x
mul_pp r1.y, r1.y, c4.y
nrm_pp r2.xyz, v1
mov_pp r3.x, v2.w
mov_pp r3.y, v3.w
mov_pp r3.z, v4.w
dp3_pp r1.z, r3, r3
rsq_pp r1.z, r1.z
mad_pp r4.xyz, r3, r1.z, -r2
mul_pp r3.xyz, r1.z, r3
nrm_pp r5.xyz, r4
nrm_pp r4.xyz, v4
dp3_pp r1.z, r4, r5
dp3_pp r2.w, r3, r5
dp3_pp r3.x, r4, r3
dp3_pp r2.x, r4, -r2
max_pp r3.y, r2.x, c9.y
max_pp r2.x, r3.x, c9.y
max_pp r3.x, r2.w, c9.y
max_pp r2.y, r1.z, c9.y
pow_pp r3.z, r2.y, r1.x
mul_pp r1.x, r1.y, r3.z
mul_pp r1.y, r0.w, r0.w
mul_pp r1.z, r1.y, c4.w
mad_pp r1.y, r1.y, -c4.w, r1.w
mad_pp r1.w, r3.y, r1.y, r1.z
add_pp r2.y, -r3.y, c8.w
mad_pp r1.y, r2.x, r1.y, r1.z
mad r1.y, r1.y, r1.w, c9.z
rcp_pp r1.y, r1.y
mul_pp r1.x, r1.x, r1.y
mul_pp r1.x, r2.x, r1.x
mul_pp r1.x, r1.x, c4.x
max_pp r2.z, r1.x, c9.y
mul_pp r1.xyz, r0, r2.z
add_pp r1.w, -r3.x, c8.w
mul_pp r2.z, r3.x, r3.x
dp2add_pp r0.w, r2.z, r0.w, c10.z
mul_pp r2.z, r1.w, r1.w
mul_pp r2.z, r2.z, r2.z
mul_pp r1.w, r1.w, r2.z
texld r3, v0, s0
mov r4, c2
mad_pp r5.xyz, c5, r3, -r4
mul_pp r3.xyz, r3, c5
mad_pp r4.xyz, c6.x, r5, r4
lrp_pp r5.xyz, r1.w, c8.w, r4
mul_pp r1.xyz, r1, r5
mul_pp r1.w, r2.y, r2.y
mul_pp r1.w, r1.w, r1.w
mul_pp r1.w, r2.y, r1.w
mad_pp r1.w, r0.w, r1.w, c8.w
add_pp r2.y, -r2.x, c8.w
mul_pp r2.z, r2.y, r2.y
mul_pp r2.z, r2.z, r2.z
mul_pp r2.y, r2.y, r2.z
mad_pp r0.w, r0.w, r2.y, c8.w
mul_pp r0.w, r1.w, r0.w
mul_pp r0.w, r2.x, r0.w
mul_pp r0.xyz, r0.w, r0
mad_pp r0.w, c6.x, -r4.w, r4.w
mul_pp r2.xyz, r0.w, r3
mad_pp oC0.xyz, r2, r0, r1
mov_pp oC0.w, c8.w

"
}
SubProgram "d3d11 " {
// Stats: 86 math, 6 textures
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [_ShadowMapTexture] CUBE 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedkcflgnhfciopmdkbgdppepcjdnkmdifgabaaaaaaeaaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpaamaaaaeaaaaaaadmadaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaa
gcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaabaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaomfbhidpaaaaaaakocaabaaaaaaaaaaaagbjbaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaadmaaaaaadmefaaaaajpcaabaaa
abaaaaaajgahbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaaaaaaaak
ocaabaaaaaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalm
aaaaaadmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadgaaaaafccaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaak
ocaabaaaaaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaadm
aaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaak
ocaabaaaaaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaalm
aaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaacaaaaaadbaaaaah
pcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaadhaaaaanpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaagiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadobaaaaaahccaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadgaaaaaf
bcaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaa
aeaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaapgapbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahccaabaaa
abaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaadeaaaaakfcaabaaaabaaaaaa
agadbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaaaoaaaaahbcaabaaaacaaaaaaabeaaaaaaaaacaebakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaaiccaabaaaacaaaaaaakaabaaaacaaaaaa
dkiacaaaaaaaaaaaaiaaaaaadcaaaaalbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaa
acaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaacaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
bhlhnbdiaoaaaaakbcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaaapaaaaahecaabaaa
abaaaaaakgakbaaaabaaaaaapgapbaaaabaaaaaaaaaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaalpdiaaaaahicaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaaeaaaaaaegiccaaaaaaaaaaaajaaaaaa
egacbaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaa
aeaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
acaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaanicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 99 math, 7 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 5 [_Color]
Float 7 [_Glossiness]
Vector 3 [_LightColor0]
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Float 6 [_Metallic]
Vector 2 [unity_ColorSpaceDielectricSpec]
Vector 4 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] CUBE 1
SetTexture 2 [_LightTexture0] CUBE 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_3_0
def c8, 0.0078125, -0.0078125, 0.970000029, 1
def c9, 0.25, 0, 9.99999975e-005, 10
def c10, 0.967999995, 0.0299999993, -0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.w
dcl_texcoord3_pp v3.w
dcl_texcoord4_pp v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_2d s0
dcl_cube s1
dcl_cube s2
dcl_2d s3
dp3 r0.x, v6, v6
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0.x, c0.w
add r0.yzw, c8.x, v6.xxyz
texld r1, r0.yzww, s1
add r0.yzw, c8.xyyx, v6.xxyz
texld r2, r0.yzww, s1
mov r1.y, r2.x
add r0.yzw, c8.xyxy, v6.xxyz
texld r2, r0.yzww, s1
mov r1.z, r2.x
add r0.yzw, c8.xxyy, v6.xxyz
texld r2, r0.yzww, s1
mov r1.w, r2.x
mad r0, r0.x, -c8.z, r1
mov r1.w, c8.w
cmp_pp r0, r0, r1.w, c1.x
dp4_pp r0.x, r0, c9.x
dp3 r0.y, v5, v5
texld r2, r0.y, s3
texld r3, v5, s2
mul r0.y, r2.x, r3.w
mul_pp r0.x, r0.x, r0.y
mul_pp r0.xyz, r0.x, c3
add_pp r0.w, r1.w, -c7.x
add_pp r1.x, -r0.w, c8.w
mad_pp r1.x, r1.x, c10.x, c10.y
log_pp r1.x, r1.x
rcp r1.x, r1.x
mul_pp r1.x, r1.x, c9.w
mad_pp r1.y, r1.x, r1.x, c8.w
mul_pp r1.x, r1.x, r1.x
mul_pp r1.y, r1.y, c4.y
nrm_pp r2.xyz, v1
mov_pp r3.x, v2.w
mov_pp r3.y, v3.w
mov_pp r3.z, v4.w
dp3_pp r1.z, r3, r3
rsq_pp r1.z, r1.z
mad_pp r4.xyz, r3, r1.z, -r2
mul_pp r3.xyz, r1.z, r3
nrm_pp r5.xyz, r4
nrm_pp r4.xyz, v4
dp3_pp r1.z, r4, r5
dp3_pp r2.w, r3, r5
dp3_pp r3.x, r4, r3
dp3_pp r2.x, r4, -r2
max_pp r3.y, r2.x, c9.y
max_pp r2.x, r3.x, c9.y
max_pp r3.x, r2.w, c9.y
max_pp r2.y, r1.z, c9.y
pow_pp r3.z, r2.y, r1.x
mul_pp r1.x, r1.y, r3.z
mul_pp r1.y, r0.w, r0.w
mul_pp r1.z, r1.y, c4.w
mad_pp r1.y, r1.y, -c4.w, r1.w
mad_pp r1.w, r3.y, r1.y, r1.z
add_pp r2.y, -r3.y, c8.w
mad_pp r1.y, r2.x, r1.y, r1.z
mad r1.y, r1.y, r1.w, c9.z
rcp_pp r1.y, r1.y
mul_pp r1.x, r1.x, r1.y
mul_pp r1.x, r2.x, r1.x
mul_pp r1.x, r1.x, c4.x
max_pp r2.z, r1.x, c9.y
mul_pp r1.xyz, r0, r2.z
add_pp r1.w, -r3.x, c8.w
mul_pp r2.z, r3.x, r3.x
dp2add_pp r0.w, r2.z, r0.w, c10.z
mul_pp r2.z, r1.w, r1.w
mul_pp r2.z, r2.z, r2.z
mul_pp r1.w, r1.w, r2.z
texld r3, v0, s0
mov r4, c2
mad_pp r5.xyz, c5, r3, -r4
mul_pp r3.xyz, r3, c5
mad_pp r4.xyz, c6.x, r5, r4
lrp_pp r5.xyz, r1.w, c8.w, r4
mul_pp r1.xyz, r1, r5
mul_pp r1.w, r2.y, r2.y
mul_pp r1.w, r1.w, r1.w
mul_pp r1.w, r2.y, r1.w
mad_pp r1.w, r0.w, r1.w, c8.w
add_pp r2.y, -r2.x, c8.w
mul_pp r2.z, r2.y, r2.y
mul_pp r2.z, r2.z, r2.z
mul_pp r2.y, r2.y, r2.z
mad_pp r0.w, r0.w, r2.y, c8.w
mul_pp r0.w, r1.w, r0.w
mul_pp r0.w, r2.x, r0.w
mul_pp r0.xyz, r0.w, r0
mad_pp r0.w, c6.x, -r4.w, r4.w
mul_pp r2.xyz, r0.w, r3
mad_pp oC0.xyz, r2, r0, r1
mov_pp oC0.w, c8.w

"
}
SubProgram "d3d11 " {
// Stats: 87 math, 7 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTextureB0] 2D 3
SetTexture 2 [_LightTexture0] CUBE 2
SetTexture 3 [_ShadowMapTexture] CUBE 1
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedopkloelgicgpmoogggionlnbebkckghdabaaaaaajmaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcemanaaaaeaaaaaaafdadaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaa
acaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaad
icbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaomfbhidpaaaaaaakocaabaaaaaaaaaaaagbjbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaaadmaaaaaadmaaaaaadmefaaaaajpcaabaaaabaaaaaa
jgahbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaaaaaaaakocaabaaa
aaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadm
efaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
abaaaaaadgaaaaafccaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaakocaabaaa
aaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaadmaaaaaalm
efaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
abaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaakocaabaaa
aaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaalmaaaaaalm
efaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaacaaaaaadbaaaaahpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaagiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaiadoaaaaiadoaaaaiadoaaaaiadobaaaaaahccaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaa
agaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadgaaaaafbcaabaaa
acaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaa
dgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahccaabaaaabaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaadeaaaaakfcaabaaaabaaaaaaagadbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
anaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaaaoaaaaahbcaabaaaacaaaaaaabeaaaaaaaaacaebakaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaaiaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
acaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaaiccaabaaaacaaaaaaakaabaaaacaaaaaadkiacaaa
aaaaaaaaaiaaaaaadcaaaaalbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaaacaaaaaa
akaabaaaabaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaa
acaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaabhlhnbdi
aoaaaaakbcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
acaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaackaabaaaabaaaaaaapaaaaahecaabaaaabaaaaaa
kgakbaaaabaaaaaapgapbaaaabaaaaaaaaaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaalpdiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaaeaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaa
adaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaadaaaaaa
egacbaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaaaeaaaaaa
kgikcaaaaaaaaaaaanaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaacaaaaaa
aaaaaaalhcaabaaaafaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaanicaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 25 avg math (9..41)
 //        d3d9 : 24 avg math (8..41)
 //      opengl : 2 avg math (1..3)
 // Stats for Fragment shader:
 //       d3d11 : 3 math
 //        d3d9 : 3 avg math (2..4)
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  GpuProgramID 172554
Program "vp" {
SubProgram "opengl " {
// Stats: 1 math
Keywords { "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_LightShadowBias;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform mat4 unity_MatrixVP;
void main ()
{
  vec3 vertex_1;
  vertex_1 = gl_Vertex.xyz;
  vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    vec3 tmpvar_4;
    tmpvar_4 = (_Object2World * tmpvar_3).xyz;
    vec4 v_5;
    v_5.x = _World2Object[0].x;
    v_5.y = _World2Object[1].x;
    v_5.z = _World2Object[2].x;
    v_5.w = _World2Object[3].x;
    vec4 v_6;
    v_6.x = _World2Object[0].y;
    v_6.y = _World2Object[1].y;
    v_6.z = _World2Object[2].y;
    v_6.w = _World2Object[3].y;
    vec4 v_7;
    v_7.x = _World2Object[0].z;
    v_7.y = _World2Object[1].z;
    v_7.z = _World2Object[2].z;
    v_7.w = _World2Object[3].z;
    vec3 tmpvar_8;
    tmpvar_8 = normalize(((
      (v_5.xyz * gl_Normal.x)
     + 
      (v_6.xyz * gl_Normal.y)
    ) + (v_7.xyz * gl_Normal.z)));
    float tmpvar_9;
    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_10);
  } else {
    vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = vertex_1;
    clipPos_2 = (gl_ModelViewProjectionMatrix * tmpvar_11);
  };
  vec4 clipPos_12;
  clipPos_12.xyw = clipPos_2.xyw;
  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_12;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_MatrixVP]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_LightShadowBias]
"vs_3_0
def c16, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord o0
dcl_position o1
abs r0.x, c15.z
slt r0.x, -r0.x, r0.x
mul r0.yzw, c12.xxyz, v1.y
mad r0.yzw, c11.xxyz, v1.x, r0
mad r0.yzw, c13.xxyz, v1.z, r0
nrm r1.xyz, r0.yzww
mad r2, v0.xyzx, c16.xxxy, c16.yyyx
dp4 r3.x, c8, r2
dp4 r3.y, c9, r2
dp4 r3.z, c10, r2
mad r0.yzw, r3.xxyz, -c14.w, c14.xxyz
nrm r4.xyz, r0.yzww
dp3 r0.y, r1, r4
mad r0.y, r0.y, -r0.y, c16.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.y, c15.z
mad r1.xyz, r1, -r0.y, r3
mov r1.w, c16.x
dp4 r3.x, c4, r1
dp4 r3.y, c5, r1
dp4 r3.z, c6, r1
dp4 r3.w, c7, r1
dp4 r1.x, c0, r2
dp4 r1.y, c1, r2
dp4 r1.z, c2, r2
dp4 r1.w, c3, r2
lrp r2, r0.x, r3, r1
rcp r0.x, r2.w
mul_sat r0.x, r0.x, c15.x
add r0.x, r0.x, r2.z
max r0.y, r0.x, c16.y
lrp r2.z, c15.y, r0.y, r0.x
mov o0, r2
mov o1, r2

"
}
SubProgram "d3d11 " {
// Stats: 41 math
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 80 [unity_LightShadowBias]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityPerFrame" 256
Matrix 144 [unity_MatrixVP]
BindCB  "UnityLighting" 0
BindCB  "UnityShadows" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityPerFrame" 3
"vs_4_0
eefiecedkofcienalkjfdbfghdeacmmpolplmbnoabaaaaaamaagaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafdeieefcoeafaaaaeaaaabaa
hjabaaaafjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaa
anaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagiaaaaacadaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaabaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaabaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaabaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaabaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaabaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaabaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
abaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
abaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
abaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
pgipcaaaaaaaaaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
akaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaajaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
alaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaacaaaaaa
adaaaaaadjaaaaaibcaabaaaacaaaaaackiacaaaabaaaaaaafaaaaaaabeaaaaa
aaaaaaaadhaaaaajpcaabaaaaaaaaaaaagaabaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaocaaaaibcaabaaaabaaaaaaakiacaaaabaaaaaaafaaaaaa
dkaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaaflccabaaaaaaaaaaaegambaaaaaaaaaaadeaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakeccabaaaaaaaaaaa
bkiacaaaabaaaaaaafaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
// Stats: 3 math
Keywords { "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  xlv_TEXCOORD0 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = vec4((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) * _LightPositionRange.w));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 7 [_LightPositionRange]
"vs_3_0
dcl_position v0
dcl_texcoord o0.xyz
dcl_position o1
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o0.xyz, r0, -c7
dp4 o1.x, c0, v0
dp4 o1.y, c1, v0
dp4 o1.z, c2, v0
dp4 o1.w, c3, v0

"
}
SubProgram "d3d11 " {
// Stats: 9 math
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmgkmdmiimpgfbbeijlbbhnckjdimdhfoabaaaaaalaacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaahaiaaaaebaaaaaaaaaaaaaaabaaaaaaadaaaaaaabaaaaaaapaaaaaa
feeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaklklklfdeieefclaabaaaa
eaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaagfaaaaadhccabaaaaaaaaaaa
ghaaaaaepccabaaaabaaaaaaabaaaaaagiaaaaacabaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 2 math
Keywords { "SHADOWS_DEPTH" }
"ps_3_0
dcl_texcoord v0.zw
rcp r0.x, v0.w
mul_pp oC0, r0.x, v0.z

"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
"ps_4_0
eefiecednmfgmafnpgdjlbeekdafekgfpapnijkfabaaaaaalaaaaaaaadaaaaaa
cmaaaaaadmaaaaaahaaaaaaaejfdeheoaiaaaaaaaaaaaaaaaiaaaaaaepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaaaoaaaaaa
gfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 4 math
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
"ps_3_0
dcl_texcoord v0.xyz
dp3 r0.x, v0, v0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul_pp oC0, r0.x, c0.w

"
}
SubProgram "d3d11 " {
// Stats: 3 math
Keywords { "SHADOWS_CUBE" }
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
BindCB  "UnityLighting" 0
"ps_4_0
eefiecedfnmflbfjaemdcoihgjpopakokhefifnoabaaaaaaciabaaaaadaaaaaa
cmaaaaaagaaaaaaajeaaaaaaejfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaahahaaaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimaaaaaaeaaaaaaa
cdaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaagcbaaaadhcbabaaaaaaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaaaaaaaaegbcbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaipccabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaadoaaaaab"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 33 math
 //        d3d9 : 34 math
 //      opengl : 89 avg math (88..90), 4 texture, 9 branch
 // Stats for Fragment shader:
 //       d3d11 : 85 avg math (85..86), 2 texture, 4 branch
 //        d3d9 : 100 avg math (99..102), 6 texture, 5 branch
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "RenderType"="Opaque" "PerformanceChecks"="False" }
  GpuProgramID 219066
Program "vp" {
SubProgram "opengl " {
// Stats: 90 math, 4 textures, 9 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  vec4 tmpvar_9;
  tmpvar_9 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_15;
  vec3 x2_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_16.x = dot (unity_SHBr, tmpvar_17);
  x2_16.y = dot (unity_SHBg, tmpvar_17);
  x2_16.z = dot (unity_SHBb, tmpvar_17);
  tmpvar_6.xyz = (x2_16 + (unity_SHC.xyz * (
    (tmpvar_15.x * tmpvar_15.x)
   - 
    (tmpvar_15.y * tmpvar_15.y)
  )));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec2 tmpvar_3;
  tmpvar_3.x = _Metallic;
  tmpvar_3.y = _Glossiness;
  float tmpvar_4;
  tmpvar_4 = tmpvar_3.y;
  vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_5, vec3(_Metallic));
  float tmpvar_8;
  tmpvar_8 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_6 = (tmpvar_5 * tmpvar_8);
  float tmpvar_9;
  tmpvar_9 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1;
  vec3 x1_13;
  x1_13.x = dot (unity_SHAr, tmpvar_12);
  x1_13.y = dot (unity_SHAg, tmpvar_12);
  x1_13.z = dot (unity_SHAb, tmpvar_12);
  tmpvar_10 = (xlv_TEXCOORD5.xyz + x1_13);
  tmpvar_10 = (tmpvar_10 * tmpvar_9);
  vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_2 - (2.0 * (
    dot (tmpvar_1, tmpvar_2)
   * tmpvar_1)));
  vec3 worldNormal_15;
  worldNormal_15 = tmpvar_14;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_16;
    tmpvar_16 = normalize(tmpvar_14);
    vec3 tmpvar_17;
    tmpvar_17 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD6) / tmpvar_16);
    vec3 tmpvar_18;
    tmpvar_18 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD6) / tmpvar_16);
    bvec3 tmpvar_19;
    tmpvar_19 = greaterThan (tmpvar_16, vec3(0.0, 0.0, 0.0));
    float tmpvar_20;
    if (tmpvar_19.x) {
      tmpvar_20 = tmpvar_17.x;
    } else {
      tmpvar_20 = tmpvar_18.x;
    };
    float tmpvar_21;
    if (tmpvar_19.y) {
      tmpvar_21 = tmpvar_17.y;
    } else {
      tmpvar_21 = tmpvar_18.y;
    };
    float tmpvar_22;
    if (tmpvar_19.z) {
      tmpvar_22 = tmpvar_17.z;
    } else {
      tmpvar_22 = tmpvar_18.z;
    };
    vec3 tmpvar_23;
    tmpvar_23 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_15 = (((
      (tmpvar_23 - unity_SpecCube0_ProbePosition.xyz)
     + xlv_TEXCOORD6) + (tmpvar_16 * 
      min (min (tmpvar_20, tmpvar_21), tmpvar_22)
    )) - tmpvar_23);
  };
  vec4 tmpvar_24;
  tmpvar_24.xyz = worldNormal_15;
  tmpvar_24.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
  vec4 tmpvar_25;
  tmpvar_25 = textureCubeLod (unity_SpecCube0, worldNormal_15, tmpvar_24.w);
  vec3 tmpvar_26;
  tmpvar_26 = ((unity_SpecCube0_HDR.x * pow (tmpvar_25.w, unity_SpecCube0_HDR.y)) * tmpvar_25.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_27;
    worldNormal_27 = tmpvar_14;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_28;
      tmpvar_28 = normalize(tmpvar_14);
      vec3 tmpvar_29;
      tmpvar_29 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD6) / tmpvar_28);
      vec3 tmpvar_30;
      tmpvar_30 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD6) / tmpvar_28);
      bvec3 tmpvar_31;
      tmpvar_31 = greaterThan (tmpvar_28, vec3(0.0, 0.0, 0.0));
      float tmpvar_32;
      if (tmpvar_31.x) {
        tmpvar_32 = tmpvar_29.x;
      } else {
        tmpvar_32 = tmpvar_30.x;
      };
      float tmpvar_33;
      if (tmpvar_31.y) {
        tmpvar_33 = tmpvar_29.y;
      } else {
        tmpvar_33 = tmpvar_30.y;
      };
      float tmpvar_34;
      if (tmpvar_31.z) {
        tmpvar_34 = tmpvar_29.z;
      } else {
        tmpvar_34 = tmpvar_30.z;
      };
      vec3 tmpvar_35;
      tmpvar_35 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_27 = (((
        (tmpvar_35 - unity_SpecCube1_ProbePosition.xyz)
       + xlv_TEXCOORD6) + (tmpvar_28 * 
        min (min (tmpvar_32, tmpvar_33), tmpvar_34)
      )) - tmpvar_35);
    };
    vec4 tmpvar_36;
    tmpvar_36.xyz = worldNormal_27;
    tmpvar_36.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
    vec4 tmpvar_37;
    tmpvar_37 = textureCubeLod (unity_SpecCube1, worldNormal_27, tmpvar_36.w);
    tmpvar_11 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_37.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_37.xyz), tmpvar_26, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_11 = tmpvar_26;
  };
  tmpvar_11 = (tmpvar_11 * tmpvar_9);
  float x_38;
  x_38 = (1.0 - max (0.0, dot (tmpvar_1, 
    -(tmpvar_2)
  )));
  vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_6 * tmpvar_10) + (tmpvar_11 * mix (tmpvar_7, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_8)), 0.0, 1.0)
  ), vec3(
    ((((x_38 * x_38) * x_38) * x_38) * x_38)
  ))));
  vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_6;
  tmpvar_40.w = tmpvar_9;
  vec4 tmpvar_41;
  tmpvar_41.xyz = tmpvar_7;
  tmpvar_41.w = tmpvar_4;
  vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = ((tmpvar_1 * 0.5) + 0.5);
  vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = exp2(-(tmpvar_39.xyz));
  gl_FragData[0] = tmpvar_40;
  gl_FragData[1] = tmpvar_41;
  gl_FragData[2] = tmpvar_42;
  gl_FragData[3] = tmpvar_43;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 34 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_DetailAlbedoMap_ST]
Vector 15 [_MainTex_ST]
Float 17 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [unity_SHBb]
Vector 12 [unity_SHBg]
Vector 11 [unity_SHBr]
Vector 14 [unity_SHC]
"vs_3_0
def c18, 0, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c15, c15.zwzw
abs r0.x, c17.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c16.xyxy, c16
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c10
mov o7.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
mov o5.xyz, r1
dp4 r1.x, c11, r2
dp4 r1.y, c12, r2
dp4 r1.z, c13, r2
mad o6.xyz, c14, r0.x, r1
mov o3, c18.x
mov o4, c18.x
mov o5.w, c18.x
mov o6.w, c18.x

"
}
SubProgram "d3d11 " {
// Stats: 33 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedocjglmajhjejpdbgpfboaljljfioajhjabaaaaaajmahaaaaadaaaaaa
cmaaaaaaliaaaaaakaabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcpeafaaaaeaaaabaahnabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaa
egbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgaaaaaf
hccabaaaahaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaaaaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaaaaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaaaaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaak
hccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaagaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 88 math, 4 textures, 9 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  vec4 tmpvar_9;
  tmpvar_9 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_15;
  vec3 x2_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_16.x = dot (unity_SHBr, tmpvar_17);
  x2_16.y = dot (unity_SHBg, tmpvar_17);
  x2_16.z = dot (unity_SHBb, tmpvar_17);
  tmpvar_6.xyz = (x2_16 + (unity_SHC.xyz * (
    (tmpvar_15.x * tmpvar_15.x)
   - 
    (tmpvar_15.y * tmpvar_15.y)
  )));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec2 tmpvar_3;
  tmpvar_3.x = _Metallic;
  tmpvar_3.y = _Glossiness;
  float tmpvar_4;
  tmpvar_4 = tmpvar_3.y;
  vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_5, vec3(_Metallic));
  float tmpvar_8;
  tmpvar_8 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_6 = (tmpvar_5 * tmpvar_8);
  float tmpvar_9;
  tmpvar_9 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1;
  vec3 x1_13;
  x1_13.x = dot (unity_SHAr, tmpvar_12);
  x1_13.y = dot (unity_SHAg, tmpvar_12);
  x1_13.z = dot (unity_SHAb, tmpvar_12);
  tmpvar_10 = (xlv_TEXCOORD5.xyz + x1_13);
  tmpvar_10 = (tmpvar_10 * tmpvar_9);
  vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_2 - (2.0 * (
    dot (tmpvar_1, tmpvar_2)
   * tmpvar_1)));
  vec3 worldNormal_15;
  worldNormal_15 = tmpvar_14;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_16;
    tmpvar_16 = normalize(tmpvar_14);
    vec3 tmpvar_17;
    tmpvar_17 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD6) / tmpvar_16);
    vec3 tmpvar_18;
    tmpvar_18 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD6) / tmpvar_16);
    bvec3 tmpvar_19;
    tmpvar_19 = greaterThan (tmpvar_16, vec3(0.0, 0.0, 0.0));
    float tmpvar_20;
    if (tmpvar_19.x) {
      tmpvar_20 = tmpvar_17.x;
    } else {
      tmpvar_20 = tmpvar_18.x;
    };
    float tmpvar_21;
    if (tmpvar_19.y) {
      tmpvar_21 = tmpvar_17.y;
    } else {
      tmpvar_21 = tmpvar_18.y;
    };
    float tmpvar_22;
    if (tmpvar_19.z) {
      tmpvar_22 = tmpvar_17.z;
    } else {
      tmpvar_22 = tmpvar_18.z;
    };
    vec3 tmpvar_23;
    tmpvar_23 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_15 = (((
      (tmpvar_23 - unity_SpecCube0_ProbePosition.xyz)
     + xlv_TEXCOORD6) + (tmpvar_16 * 
      min (min (tmpvar_20, tmpvar_21), tmpvar_22)
    )) - tmpvar_23);
  };
  vec4 tmpvar_24;
  tmpvar_24.xyz = worldNormal_15;
  tmpvar_24.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
  vec4 tmpvar_25;
  tmpvar_25 = textureCubeLod (unity_SpecCube0, worldNormal_15, tmpvar_24.w);
  vec3 tmpvar_26;
  tmpvar_26 = ((unity_SpecCube0_HDR.x * pow (tmpvar_25.w, unity_SpecCube0_HDR.y)) * tmpvar_25.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_27;
    worldNormal_27 = tmpvar_14;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_28;
      tmpvar_28 = normalize(tmpvar_14);
      vec3 tmpvar_29;
      tmpvar_29 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD6) / tmpvar_28);
      vec3 tmpvar_30;
      tmpvar_30 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD6) / tmpvar_28);
      bvec3 tmpvar_31;
      tmpvar_31 = greaterThan (tmpvar_28, vec3(0.0, 0.0, 0.0));
      float tmpvar_32;
      if (tmpvar_31.x) {
        tmpvar_32 = tmpvar_29.x;
      } else {
        tmpvar_32 = tmpvar_30.x;
      };
      float tmpvar_33;
      if (tmpvar_31.y) {
        tmpvar_33 = tmpvar_29.y;
      } else {
        tmpvar_33 = tmpvar_30.y;
      };
      float tmpvar_34;
      if (tmpvar_31.z) {
        tmpvar_34 = tmpvar_29.z;
      } else {
        tmpvar_34 = tmpvar_30.z;
      };
      vec3 tmpvar_35;
      tmpvar_35 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_27 = (((
        (tmpvar_35 - unity_SpecCube1_ProbePosition.xyz)
       + xlv_TEXCOORD6) + (tmpvar_28 * 
        min (min (tmpvar_32, tmpvar_33), tmpvar_34)
      )) - tmpvar_35);
    };
    vec4 tmpvar_36;
    tmpvar_36.xyz = worldNormal_27;
    tmpvar_36.w = (pow ((1.0 - _Glossiness), 0.75) * 7.0);
    vec4 tmpvar_37;
    tmpvar_37 = textureCubeLod (unity_SpecCube1, worldNormal_27, tmpvar_36.w);
    tmpvar_11 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_37.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_37.xyz), tmpvar_26, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_11 = tmpvar_26;
  };
  tmpvar_11 = (tmpvar_11 * tmpvar_9);
  float x_38;
  x_38 = (1.0 - max (0.0, dot (tmpvar_1, 
    -(tmpvar_2)
  )));
  vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_6 * tmpvar_10) + (tmpvar_11 * mix (tmpvar_7, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_8)), 0.0, 1.0)
  ), vec3(
    ((((x_38 * x_38) * x_38) * x_38) * x_38)
  ))));
  vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_6;
  tmpvar_40.w = tmpvar_9;
  vec4 tmpvar_41;
  tmpvar_41.xyz = tmpvar_7;
  tmpvar_41.w = tmpvar_4;
  vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = ((tmpvar_1 * 0.5) + 0.5);
  vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = tmpvar_39.xyz;
  gl_FragData[0] = tmpvar_40;
  gl_FragData[1] = tmpvar_41;
  gl_FragData[2] = tmpvar_42;
  gl_FragData[3] = tmpvar_43;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 34 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_DetailAlbedoMap_ST]
Vector 15 [_MainTex_ST]
Float 17 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [unity_SHBb]
Vector 12 [unity_SHBg]
Vector 11 [unity_SHBr]
Vector 14 [unity_SHC]
"vs_3_0
def c18, 0, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c15, c15.zwzw
abs r0.x, c17.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad o1.zw, r2.xyxy, c16.xyxy, c16
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add o2.xyz, r0, -c10
mov o7.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
mov o5.xyz, r1
dp4 r1.x, c11, r2
dp4 r1.y, c12, r2
dp4 r1.z, c13, r2
mad o6.xyz, c14, r0.x, r1
mov o3, c18.x
mov o4, c18.x
mov o5.w, c18.x
mov o6.w, c18.x

"
}
SubProgram "d3d11 " {
// Stats: 33 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedocjglmajhjejpdbgpfboaljljfioajhjabaaaaaajmahaaaaadaaaaaa
cmaaaaaaliaaaaaakaabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcpeafaaaaeaaaabaahnabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaa
egbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgaaaaaf
hccabaaaahaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaaaaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaaaaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaaaaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaak
hccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaagaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 102 math, 6 textures, 5 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 12 [_Color]
Float 14 [_Glossiness]
Float 13 [_Metallic]
Float 15 [_OcclusionStrength]
Vector 11 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_SHAb]
Vector 1 [unity_SHAg]
Vector 0 [unity_SHAr]
Vector 3 [unity_SpecCube0_BoxMax]
Vector 4 [unity_SpecCube0_BoxMin]
Vector 6 [unity_SpecCube0_HDR]
Vector 5 [unity_SpecCube0_ProbePosition]
Vector 7 [unity_SpecCube1_BoxMax]
Vector 8 [unity_SpecCube1_BoxMin]
Vector 10 [unity_SpecCube1_HDR]
Vector 9 [unity_SpecCube1_ProbePosition]
SetTexture 0 [unity_SpecCube0] CUBE 0
SetTexture 1 [unity_SpecCube1] CUBE 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_OcclusionMap] 2D 3
"ps_3_0
def c16, 7, 0.999989986, 0, 0
def c17, 1, 0, 0.5, 0.75
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord4_pp v2.xyz
dcl_texcoord5_pp v3.xyz
dcl_texcoord6_pp v4.xyz
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
nrm_pp r0.xyz, v2
nrm_pp r1.xyz, v1
texld r2, v0, s2
mul_pp r3.xyz, r2, c12
mov r4, c11
mad_pp r2.xyz, c12, r2, -r4
mad_pp r2.xyz, c13.x, r2, r4
mad_pp r1.w, c13.x, -r4.w, r4.w
mul_pp r3.xyz, r1.w, r3
texld_pp r4, v0, s3
mov r5.xyz, c17
add_pp r2.w, r5.x, -c15.x
mad_pp r3.w, r4.y, c15.x, r2.w
mov r0.w, c17.x
dp4_pp r4.x, c0, r0
dp4_pp r4.y, c1, r0
dp4_pp r4.z, c2, r0
add_pp r4.xyz, r4, v3
mul_pp r4.xyz, r3.w, r4
dp3 r2.w, r1, r0
add r2.w, r2.w, r2.w
mad_pp r6.xyz, r0, -r2.w, r1
if_lt -c5.w, r5.y
nrm_pp r7.xyz, r6
add r8.xyz, c3, -v4
rcp r9.x, r7.x
rcp r9.y, r7.y
rcp r9.z, r7.z
mul_pp r8.xyz, r8, r9
add r10.xyz, c4, -v4
mul_pp r9.xyz, r9, r10
cmp_pp r8.xyz, -r7, r9, r8
min_pp r2.w, r8.y, r8.x
min_pp r4.w, r8.z, r2.w
mov r8.xyz, c4
add r8.xyz, r8, c3
mad r9.xyz, r8, r5.z, -c5
add r9.xyz, r9, v4
mad r7.xyz, r7, r4.w, r9
mad_pp r7.xyz, r8, -c17.z, r7
else
mov_pp r7.xyz, r6
endif
add_pp r2.w, r5.x, -c14.x
pow_pp r4.w, r2.w, c17.w
mul_pp r7.w, r4.w, c16.x
texldl_pp r8, r7, s0
pow_pp r2.w, r8.w, c6.y
mul_pp r2.w, r2.w, c6.x
mul_pp r9.xyz, r8, r2.w
mov r4.w, c4.w
if_lt r4.w, c16.y
if_lt -c9.w, r5.y
nrm_pp r10.xyz, r6
add r5.xyw, c7.xyzz, -v4.xyzz
rcp r11.x, r10.x
rcp r11.y, r10.y
rcp r11.z, r10.z
mul_pp r5.xyw, r5, r11.xyzz
add r12.xyz, c8, -v4
mul_pp r11.xyz, r11, r12
cmp_pp r5.xyw, -r10.xyzz, r11.xyzz, r5
min_pp r4.w, r5.y, r5.x
min_pp r6.w, r5.w, r4.w
mov r11.xyz, c7
add r5.xyw, r11.xyzz, c8.xyzz
mad r11.xyz, r5.xyww, r5.z, -c9
add r11.xyz, r11, v4
mad r10.xyz, r10, r6.w, r11
mad_pp r7.xyz, r5.xyww, -c17.z, r10
else
mov_pp r7.xyz, r6
endif
texldl_pp r5, r7, s1
pow_pp r4.w, r5.w, c10.y
mul_pp r4.w, r4.w, c10.x
mul_pp r5.xyz, r5, r4.w
mad r6.xyz, r2.w, r8, -r5
mad_pp r9.xyz, c4.w, r6, r5
endif
mul_pp r5.xyz, r3.w, r9
dp3_pp r1.x, r0, -r1
add_pp r1.yz, -r1.xwxw, c17.x
add_sat_pp r1.y, r1.y, c14.x
cmp_pp r1.x, r1.x, r1.z, c17.x
mul_pp r1.z, r1.x, r1.x
mul_pp r1.z, r1.z, r1.z
mul_pp r1.x, r1.x, r1.z
lrp_pp r6.xyz, r1.x, r1.y, r2
mul_pp r1.xyz, r5, r6
mad_pp r1.xyz, r3, r4, r1
exp_pp oC3.x, -r1.x
exp_pp oC3.y, -r1.y
exp_pp oC3.z, -r1.z
mov_pp oC0, r3
mov_pp oC1.w, c14.x
mov_pp oC1.xyz, r2
mad_pp oC2, r0, c17.zzzx, c17.zzzy
mov_pp oC3.w, c17.x

"
}
SubProgram "d3d11 " {
// Stats: 86 math, 2 textures, 4 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_OcclusionMap] 2D 3
SetTexture 2 [unity_SpecCube0] CUBE 0
SetTexture 3 [unity_SpecCube1] CUBE 1
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
Float 224 [_OcclusionStrength]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
ConstBuffer "UnityReflectionProbes" 128
Vector 0 [unity_SpecCube0_BoxMax]
Vector 16 [unity_SpecCube0_BoxMin]
Vector 32 [unity_SpecCube0_ProbePosition]
Vector 48 [unity_SpecCube0_HDR]
Vector 64 [unity_SpecCube1_BoxMax]
Vector 80 [unity_SpecCube1_BoxMin]
Vector 96 [unity_SpecCube1_ProbePosition]
Vector 112 [unity_SpecCube1_HDR]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityReflectionProbes" 2
"ps_4_0
eefiecedalldfegikgdidnnfbclclfaldkdehcalabaaaaaabaapaaaaadaaaaaa
cmaaaaaabeabaaaajaabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheoheaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaagiaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagiaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaagiaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchianaaaaeaaaaaaafoadaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaacjaaaaaa
fjaaaaaeegiocaaaacaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacamaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaa
aaaaaaaaajaaaaaaegacbaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaacaaaaaadcaaaaanicaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
aaaaaaajicaabaaaacaaaaaaakiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdcaaaaakicaabaaaadaaaaaabkaabaaaaeaaaaaaakiacaaaaaaaaaaa
aoaaaaaadkaabaaaacaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegbcbaaaagaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaa
aaaaaaaapgapbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadbaaaaaiicaabaaa
acaaaaaaabeaaaaaaaaaaaaadkiacaaaacaaaaaaacaaaaaabpaaaeaddkaabaaa
acaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaa
eeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaagaaaaaa
pgapbaaaacaaaaaaegacbaaaafaaaaaaaaaaaaajhcaabaaaahaaaaaaegbcbaia
ebaaaaaaahaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahhcaabaaaahaaaaaa
egacbaaaahaaaaaaegacbaaaagaaaaaaaaaaaaajhcaabaaaaiaaaaaaegbcbaia
ebaaaaaaahaaaaaaegiccaaaacaaaaaaabaaaaaaaoaaaaahhcaabaaaaiaaaaaa
egacbaaaaiaaaaaaegacbaaaagaaaaaadbaaaaakhcaabaaaajaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaagaaaaaadhaaaaajhcaabaaa
ahaaaaaaegacbaaaajaaaaaaegacbaaaahaaaaaaegacbaaaaiaaaaaaddaaaaah
icaabaaaacaaaaaabkaabaaaahaaaaaaakaabaaaahaaaaaaddaaaaahicaabaaa
acaaaaaackaabaaaahaaaaaadkaabaaaacaaaaaaaaaaaaajhcaabaaaahaaaaaa
egiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaabaaaaaadcaaaaaohcaabaaa
aiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egiccaiaebaaaaaaacaaaaaaacaaaaaaaaaaaaahhcaabaaaaiaaaaaaegacbaaa
aiaaaaaaegbcbaaaahaaaaaadcaaaaajhcaabaaaagaaaaaaegacbaaaagaaaaaa
pgapbaaaacaaaaaaegacbaaaaiaaaaaadcaaaaanhcaabaaaagaaaaaaegacbaia
ebaaaaaaahaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
agaaaaaabcaaaaabdgaaaaafhcaabaaaagaaaaaaegacbaaaafaaaaaabfaaaaab
aaaaaaajicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpcpaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaeadpbjaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaoaeaeiaaaaalpcaabaaaagaaaaaaegacbaaaagaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadkaabaaaacaaaaaacpaaaaaficaabaaaaeaaaaaadkaabaaa
agaaaaaadiaaaaaiicaabaaaaeaaaaaadkaabaaaaeaaaaaabkiacaaaacaaaaaa
adaaaaaabjaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaadiaaaaaiicaabaaa
aeaaaaaadkaabaaaaeaaaaaaakiacaaaacaaaaaaadaaaaaadiaaaaahhcaabaaa
ahaaaaaaegacbaaaagaaaaaapgapbaaaaeaaaaaadbaaaaaiicaabaaaafaaaaaa
dkiacaaaacaaaaaaabaaaaaaabeaaaaafipphpdpbpaaaeaddkaabaaaafaaaaaa
dbaaaaaiicaabaaaafaaaaaaabeaaaaaaaaaaaaadkiacaaaacaaaaaaagaaaaaa
bpaaaeaddkaabaaaafaaaaaabaaaaaahicaabaaaafaaaaaaegacbaaaafaaaaaa
egacbaaaafaaaaaaeeaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaadiaaaaah
hcaabaaaaiaaaaaapgapbaaaafaaaaaaegacbaaaafaaaaaaaaaaaaajhcaabaaa
ajaaaaaaegbcbaiaebaaaaaaahaaaaaaegiccaaaacaaaaaaaeaaaaaaaoaaaaah
hcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaaaaaaaaajhcaabaaa
akaaaaaaegbcbaiaebaaaaaaahaaaaaaegiccaaaacaaaaaaafaaaaaaaoaaaaah
hcaabaaaakaaaaaaegacbaaaakaaaaaaegacbaaaaiaaaaaadbaaaaakhcaabaaa
alaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaiaaaaaa
dhaaaaajhcaabaaaajaaaaaaegacbaaaalaaaaaaegacbaaaajaaaaaaegacbaaa
akaaaaaaddaaaaahicaabaaaafaaaaaabkaabaaaajaaaaaaakaabaaaajaaaaaa
ddaaaaahicaabaaaafaaaaaackaabaaaajaaaaaadkaabaaaafaaaaaaaaaaaaaj
hcaabaaaajaaaaaaegiccaaaacaaaaaaaeaaaaaaegiccaaaacaaaaaaafaaaaaa
dcaaaaaohcaabaaaakaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegiccaiaebaaaaaaacaaaaaaagaaaaaaaaaaaaahhcaabaaa
akaaaaaaegacbaaaakaaaaaaegbcbaaaahaaaaaadcaaaaajhcaabaaaaiaaaaaa
egacbaaaaiaaaaaapgapbaaaafaaaaaaegacbaaaakaaaaaadcaaaaanhcaabaaa
afaaaaaaegacbaiaebaaaaaaajaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaaiaaaaaabfaaaaabeiaaaaalpcaabaaaafaaaaaaegacbaaa
afaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadkaabaaaacaaaaaacpaaaaaf
icaabaaaacaaaaaadkaabaaaafaaaaaadiaaaaaiicaabaaaacaaaaaadkaabaaa
acaaaaaabkiacaaaacaaaaaaahaaaaaabjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaaakiacaaaacaaaaaa
ahaaaaaadiaaaaahhcaabaaaafaaaaaaegacbaaaafaaaaaapgapbaaaacaaaaaa
dcaaaaakhcaabaaaagaaaaaapgapbaaaaeaaaaaaegacbaaaagaaaaaaegacbaia
ebaaaaaaafaaaaaadcaaaaakhcaabaaaahaaaaaapgipcaaaacaaaaaaabaaaaaa
egacbaaaagaaaaaaegacbaaaafaaaaaabfaaaaabdiaaaaahhcaabaaaafaaaaaa
pgapbaaaadaaaaaaegacbaaaahaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaajccaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaaanaaaaaaaacaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaacaaaaaafgafbaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaafaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabjaaaaaghccabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaadaaaaaadgaaaaagiccabaaaabaaaaaadkiacaaa
aaaaaaaaanaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
pccabaaaacaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaiadpaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaa
adaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 99 math, 6 textures, 5 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Vector 12 [_Color]
Float 14 [_Glossiness]
Float 13 [_Metallic]
Float 15 [_OcclusionStrength]
Vector 11 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_SHAb]
Vector 1 [unity_SHAg]
Vector 0 [unity_SHAr]
Vector 3 [unity_SpecCube0_BoxMax]
Vector 4 [unity_SpecCube0_BoxMin]
Vector 6 [unity_SpecCube0_HDR]
Vector 5 [unity_SpecCube0_ProbePosition]
Vector 7 [unity_SpecCube1_BoxMax]
Vector 8 [unity_SpecCube1_BoxMin]
Vector 10 [unity_SpecCube1_HDR]
Vector 9 [unity_SpecCube1_ProbePosition]
SetTexture 0 [unity_SpecCube0] CUBE 0
SetTexture 1 [unity_SpecCube1] CUBE 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_OcclusionMap] 2D 3
"ps_3_0
def c16, 7, 0.999989986, 0, 0
def c17, 1, 0, 0.5, 0.75
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord4_pp v2.xyz
dcl_texcoord5_pp v3.xyz
dcl_texcoord6_pp v4.xyz
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
nrm_pp r0.xyz, v2
nrm_pp r1.xyz, v1
texld r2, v0, s2
mul_pp r3.xyz, r2, c12
mov r4, c11
mad_pp r2.xyz, c12, r2, -r4
mad_pp r2.xyz, c13.x, r2, r4
mad_pp r1.w, c13.x, -r4.w, r4.w
mul_pp r3.xyz, r1.w, r3
texld_pp r4, v0, s3
mov r5.xyz, c17
add_pp r2.w, r5.x, -c15.x
mad_pp r3.w, r4.y, c15.x, r2.w
mov r0.w, c17.x
dp4_pp r4.x, c0, r0
dp4_pp r4.y, c1, r0
dp4_pp r4.z, c2, r0
add_pp r4.xyz, r4, v3
mul_pp r4.xyz, r3.w, r4
dp3 r2.w, r1, r0
add r2.w, r2.w, r2.w
mad_pp r6.xyz, r0, -r2.w, r1
if_lt -c5.w, r5.y
nrm_pp r7.xyz, r6
add r8.xyz, c3, -v4
rcp r9.x, r7.x
rcp r9.y, r7.y
rcp r9.z, r7.z
mul_pp r8.xyz, r8, r9
add r10.xyz, c4, -v4
mul_pp r9.xyz, r9, r10
cmp_pp r8.xyz, -r7, r9, r8
min_pp r2.w, r8.y, r8.x
min_pp r4.w, r8.z, r2.w
mov r8.xyz, c4
add r8.xyz, r8, c3
mad r9.xyz, r8, r5.z, -c5
add r9.xyz, r9, v4
mad r7.xyz, r7, r4.w, r9
mad_pp r7.xyz, r8, -c17.z, r7
else
mov_pp r7.xyz, r6
endif
add_pp r2.w, r5.x, -c14.x
pow_pp r4.w, r2.w, c17.w
mul_pp r7.w, r4.w, c16.x
texldl_pp r8, r7, s0
pow_pp r2.w, r8.w, c6.y
mul_pp r2.w, r2.w, c6.x
mul_pp r9.xyz, r8, r2.w
mov r4.w, c4.w
if_lt r4.w, c16.y
if_lt -c9.w, r5.y
nrm_pp r10.xyz, r6
add r5.xyw, c7.xyzz, -v4.xyzz
rcp r11.x, r10.x
rcp r11.y, r10.y
rcp r11.z, r10.z
mul_pp r5.xyw, r5, r11.xyzz
add r12.xyz, c8, -v4
mul_pp r11.xyz, r11, r12
cmp_pp r5.xyw, -r10.xyzz, r11.xyzz, r5
min_pp r4.w, r5.y, r5.x
min_pp r6.w, r5.w, r4.w
mov r11.xyz, c7
add r5.xyw, r11.xyzz, c8.xyzz
mad r11.xyz, r5.xyww, r5.z, -c9
add r11.xyz, r11, v4
mad r10.xyz, r10, r6.w, r11
mad_pp r7.xyz, r5.xyww, -c17.z, r10
else
mov_pp r7.xyz, r6
endif
texldl_pp r5, r7, s1
pow_pp r4.w, r5.w, c10.y
mul_pp r4.w, r4.w, c10.x
mul_pp r5.xyz, r5, r4.w
mad r6.xyz, r2.w, r8, -r5
mad_pp r9.xyz, c4.w, r6, r5
endif
mul_pp r5.xyz, r3.w, r9
dp3_pp r1.x, r0, -r1
add_pp r1.yz, -r1.xwxw, c17.x
add_sat_pp r1.y, r1.y, c14.x
cmp_pp r1.x, r1.x, r1.z, c17.x
mul_pp r1.z, r1.x, r1.x
mul_pp r1.z, r1.z, r1.z
mul_pp r1.x, r1.x, r1.z
lrp_pp r6.xyz, r1.x, r1.y, r2
mul_pp r1.xyz, r5, r6
mad_pp oC3.xyz, r3, r4, r1
mov_pp oC0, r3
mov_pp oC1.w, c14.x
mov_pp oC1.xyz, r2
mad_pp oC2, r0, c17.zzzx, c17.zzzy
mov_pp oC3.w, c17.x

"
}
SubProgram "d3d11 " {
// Stats: 85 math, 2 textures, 4 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_OcclusionMap] 2D 3
SetTexture 2 [unity_SpecCube0] CUBE 0
SetTexture 3 [unity_SpecCube1] CUBE 1
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
Float 224 [_OcclusionStrength]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
ConstBuffer "UnityReflectionProbes" 128
Vector 0 [unity_SpecCube0_BoxMax]
Vector 16 [unity_SpecCube0_BoxMin]
Vector 32 [unity_SpecCube0_ProbePosition]
Vector 48 [unity_SpecCube0_HDR]
Vector 64 [unity_SpecCube1_BoxMax]
Vector 80 [unity_SpecCube1_BoxMin]
Vector 96 [unity_SpecCube1_ProbePosition]
Vector 112 [unity_SpecCube1_HDR]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityReflectionProbes" 2
"ps_4_0
eefiecedppmheoajikblmbljiddjmhilbgmddjhhabaaaaaapiaoaaaaadaaaaaa
cmaaaaaabeabaaaajaabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheoheaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaagiaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagiaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaagiaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaanaaaaeaaaaaaafiadaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaacjaaaaaa
fjaaaaaeegiocaaaacaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacamaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaa
aaaaaaaaajaaaaaaegacbaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaacaaaaaadcaaaaanicaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
aaaaaaajicaabaaaacaaaaaaakiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdcaaaaakicaabaaaadaaaaaabkaabaaaaeaaaaaaakiacaaaaaaaaaaa
aoaaaaaadkaabaaaacaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegbcbaaaagaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaa
aaaaaaaapgapbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadbaaaaaiicaabaaa
acaaaaaaabeaaaaaaaaaaaaadkiacaaaacaaaaaaacaaaaaabpaaaeaddkaabaaa
acaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaa
eeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaagaaaaaa
pgapbaaaacaaaaaaegacbaaaafaaaaaaaaaaaaajhcaabaaaahaaaaaaegbcbaia
ebaaaaaaahaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahhcaabaaaahaaaaaa
egacbaaaahaaaaaaegacbaaaagaaaaaaaaaaaaajhcaabaaaaiaaaaaaegbcbaia
ebaaaaaaahaaaaaaegiccaaaacaaaaaaabaaaaaaaoaaaaahhcaabaaaaiaaaaaa
egacbaaaaiaaaaaaegacbaaaagaaaaaadbaaaaakhcaabaaaajaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaagaaaaaadhaaaaajhcaabaaa
ahaaaaaaegacbaaaajaaaaaaegacbaaaahaaaaaaegacbaaaaiaaaaaaddaaaaah
icaabaaaacaaaaaabkaabaaaahaaaaaaakaabaaaahaaaaaaddaaaaahicaabaaa
acaaaaaackaabaaaahaaaaaadkaabaaaacaaaaaaaaaaaaajhcaabaaaahaaaaaa
egiccaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaabaaaaaadcaaaaaohcaabaaa
aiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egiccaiaebaaaaaaacaaaaaaacaaaaaaaaaaaaahhcaabaaaaiaaaaaaegacbaaa
aiaaaaaaegbcbaaaahaaaaaadcaaaaajhcaabaaaagaaaaaaegacbaaaagaaaaaa
pgapbaaaacaaaaaaegacbaaaaiaaaaaadcaaaaanhcaabaaaagaaaaaaegacbaia
ebaaaaaaahaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
agaaaaaabcaaaaabdgaaaaafhcaabaaaagaaaaaaegacbaaaafaaaaaabfaaaaab
aaaaaaajicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpcpaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaeadpbjaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaoaeaeiaaaaalpcaabaaaagaaaaaaegacbaaaagaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadkaabaaaacaaaaaacpaaaaaficaabaaaaeaaaaaadkaabaaa
agaaaaaadiaaaaaiicaabaaaaeaaaaaadkaabaaaaeaaaaaabkiacaaaacaaaaaa
adaaaaaabjaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaadiaaaaaiicaabaaa
aeaaaaaadkaabaaaaeaaaaaaakiacaaaacaaaaaaadaaaaaadiaaaaahhcaabaaa
ahaaaaaaegacbaaaagaaaaaapgapbaaaaeaaaaaadbaaaaaiicaabaaaafaaaaaa
dkiacaaaacaaaaaaabaaaaaaabeaaaaafipphpdpbpaaaeaddkaabaaaafaaaaaa
dbaaaaaiicaabaaaafaaaaaaabeaaaaaaaaaaaaadkiacaaaacaaaaaaagaaaaaa
bpaaaeaddkaabaaaafaaaaaabaaaaaahicaabaaaafaaaaaaegacbaaaafaaaaaa
egacbaaaafaaaaaaeeaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaadiaaaaah
hcaabaaaaiaaaaaapgapbaaaafaaaaaaegacbaaaafaaaaaaaaaaaaajhcaabaaa
ajaaaaaaegbcbaiaebaaaaaaahaaaaaaegiccaaaacaaaaaaaeaaaaaaaoaaaaah
hcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaaaaaaaaajhcaabaaa
akaaaaaaegbcbaiaebaaaaaaahaaaaaaegiccaaaacaaaaaaafaaaaaaaoaaaaah
hcaabaaaakaaaaaaegacbaaaakaaaaaaegacbaaaaiaaaaaadbaaaaakhcaabaaa
alaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaiaaaaaa
dhaaaaajhcaabaaaajaaaaaaegacbaaaalaaaaaaegacbaaaajaaaaaaegacbaaa
akaaaaaaddaaaaahicaabaaaafaaaaaabkaabaaaajaaaaaaakaabaaaajaaaaaa
ddaaaaahicaabaaaafaaaaaackaabaaaajaaaaaadkaabaaaafaaaaaaaaaaaaaj
hcaabaaaajaaaaaaegiccaaaacaaaaaaaeaaaaaaegiccaaaacaaaaaaafaaaaaa
dcaaaaaohcaabaaaakaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegiccaiaebaaaaaaacaaaaaaagaaaaaaaaaaaaahhcaabaaa
akaaaaaaegacbaaaakaaaaaaegbcbaaaahaaaaaadcaaaaajhcaabaaaaiaaaaaa
egacbaaaaiaaaaaapgapbaaaafaaaaaaegacbaaaakaaaaaadcaaaaanhcaabaaa
afaaaaaaegacbaiaebaaaaaaajaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaaiaaaaaabfaaaaabeiaaaaalpcaabaaaafaaaaaaegacbaaa
afaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadkaabaaaacaaaaaacpaaaaaf
icaabaaaacaaaaaadkaabaaaafaaaaaadiaaaaaiicaabaaaacaaaaaadkaabaaa
acaaaaaabkiacaaaacaaaaaaahaaaaaabjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaaakiacaaaacaaaaaa
ahaaaaaadiaaaaahhcaabaaaafaaaaaaegacbaaaafaaaaaapgapbaaaacaaaaaa
dcaaaaakhcaabaaaagaaaaaapgapbaaaaeaaaaaaegacbaaaagaaaaaaegacbaia
ebaaaaaaafaaaaaadcaaaaakhcaabaaaahaaaaaapgipcaaaacaaaaaaabaaaaaa
egacbaaaagaaaaaaegacbaaaafaaaaaabfaaaaabdiaaaaahhcaabaaaafaaaaaa
pgapbaaaadaaaaaaegacbaaaahaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaajccaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaadkiacaaaaaaaaaaaanaaaaaaaacaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaacaaaaaafgafbaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaafaaaaaa
dcaaaaajhccabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaadgaaaaagiccabaaa
abaaaaaadkiacaaaaaaaaaaaanaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaappccabaaaacaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaiadpaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
dgaaaaaficcabaaaadaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
SubShader { 
 LOD 150
 Tags { "RenderType"="Opaque" "PerformanceChecks"="False" }


 // Stats for Vertex shader:
 //       d3d11 : 51 avg math (40..63)
 //    d3d11_9x : 54 avg math (40..68)
 //        d3d9 : 57 avg math (41..74)
 //      opengl : 47 avg math (47..48), 4 avg texture (4..5)
 // Stats for Fragment shader:
 //       d3d11 : 39 avg math (38..40), 3 avg texture (3..4)
 //    d3d11_9x : 36 avg math (35..38), 3 texture
 //        d3d9 : 45 avg math (45..46), 4 avg texture (4..5)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  ZWrite [_ZWrite]
  Blend [_SrcBlend] [_DstBlend]
  GpuProgramID 361229
Program "vp" {
SubProgram "opengl " {
// Stats: 47 math, 4 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_14;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14;
  vec3 x2_16;
  vec3 x1_17;
  x1_17.x = dot (unity_SHAr, tmpvar_15);
  x1_17.y = dot (unity_SHAg, tmpvar_15);
  x1_17.z = dot (unity_SHAb, tmpvar_15);
  vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x2_16.x = dot (unity_SHBr, tmpvar_18);
  x2_16.y = dot (unity_SHBg, tmpvar_18);
  x2_16.z = dot (unity_SHBb, tmpvar_18);
  tmpvar_6.xyz = ((x2_16 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )) + x1_17);
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  float tmpvar_6;
  tmpvar_6 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_8;
  vec3 I_9;
  vec3 cse_10;
  cse_10 = -(xlv_TEXCOORD1);
  I_9 = -(cse_10);
  vec4 tmpvar_11;
  tmpvar_11.xyz = (I_9 - (2.0 * (
    dot (tmpvar_2, I_9)
   * tmpvar_2)));
  float cse_12;
  cse_12 = (1.0 - _Glossiness);
  tmpvar_11.w = (cse_12 * 7.0);
  vec4 tmpvar_13;
  tmpvar_13 = textureCube (unity_SpecCube0, tmpvar_11.xyz, tmpvar_11.w);
  tmpvar_8 = ((unity_SpecCube0_HDR.x * pow (tmpvar_13.w, unity_SpecCube0_HDR.y)) * tmpvar_13.xyz);
  tmpvar_8 = (tmpvar_8 * tmpvar_7.y);
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((cse_10 - (2.0 * 
    (dot (tmpvar_2, cse_10) * tmpvar_2)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_2, cse_10), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = (((tmpvar_14 * tmpvar_14) * tmpvar_14) * tmpvar_14);
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = cse_12;
  vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_4 + ((texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0) * tmpvar_5)) * _LightColor0.xyz)
   * 
    clamp (dot (tmpvar_2, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (xlv_TEXCOORD5.xyz * tmpvar_7.y)
   * tmpvar_4)) + (tmpvar_8 * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), tmpvar_15.yyy)));
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_17;
  c_1.w = tmpvar_18.w;
  c_1.xyz = tmpvar_17;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = c_1.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 41 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 19 [_DetailAlbedoMap_ST]
Vector 18 [_MainTex_ST]
Float 20 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [unity_SHAb]
Vector 12 [unity_SHAg]
Vector 11 [unity_SHAr]
Vector 16 [unity_SHBb]
Vector 15 [unity_SHBg]
Vector 14 [unity_SHBr]
Vector 17 [unity_SHC]
"vs_2_0
def c21, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c18, c18.zwzw
mul r0.x, c20.x, c20.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c19.xyxy, c19
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r0.xyz, r0, -c10
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c14, r2
dp4 r3.y, c15, r2
dp4 r3.z, c16, r2
mad r0.xyz, c17, r0.x, r3
mov r1.w, c21.x
dp4 r2.x, c11, r1
dp4 r2.y, c12, r1
dp4 r2.z, c13, r1
mov oT4.xyz, r1
add oT5.xyz, r0, r2
mov oT2, c21.y
mov oT3, c21.y
mov oT4.w, c21.y
mov oT5.w, c21.y

"
}
SubProgram "d3d11 " {
// Stats: 40 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcbghedpmifdfonhipeeccfijhlhpicidabaaaaaaeaaiaaaaadaaaaaa
cmaaaaaaliaaaaaaiiabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefclaagaaaaeaaaabaakmabaaaafjaaaaaeegiocaaa
aaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaagaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 40 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedegdodfjaoadklahodbedoibmimjglokiabaaaaaaceamaaaaaeaaaaaa
daaaaaaabaaeaaaamiakaaaafealaaaaebgpgodjniadaaaaniadaaaaaaacpopp
giadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaacgaaahaaafaaaaaaaaaaadaaaaaaaeaaamaaaaaaaaaaadaaamaaahaabaaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbhaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabia
aaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaia
abaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaad
aaaaahiaaaaaffjabbaaoekaaeaaaaaeaaaaahiabaaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabcaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaappjaaaaaoeiaacaaaaadaaaaahiaaaaaoeiaaeaaoekbaiaaaaadaaaaaiia
aaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoaaaaappia
aaaaoeiaafaaaaadaaaaabiaabaaaajabeaaaakaafaaaaadaaaaaciaabaaaaja
bfaaaakaafaaaaadaaaaaeiaabaaaajabgaaaakaafaaaaadabaaabiaabaaffja
beaaffkaafaaaaadabaaaciaabaaffjabfaaffkaafaaaaadabaaaeiaabaaffja
bgaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaabaakkja
beaakkkaafaaaaadabaaaciaabaakkjabfaakkkaafaaaaadabaaaeiaabaakkja
bgaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeia
afaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaia
aaaaaaibafaaaaadacaaapiaabaacjiaabaakeiaajaaaaadadaaabiaaiaaoeka
acaaoeiaajaaaaadadaaaciaajaaoekaacaaoeiaajaaaaadadaaaeiaakaaoeka
acaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiia
bhaaaakaajaaaaadacaaabiaafaaoekaabaaoeiaajaaaaadacaaaciaagaaoeka
abaaoeiaajaaaaadacaaaeiaahaaoekaabaaoeiaabaaaaacaeaaahoaabaaoeia
acaaaaadafaaahoaaaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffjaanaaoeka
aeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaoaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoabhaaffkaabaaaaacadaaapoabhaaffkaabaaaaacaeaaaioabhaaffka
abaaaaacafaaaioabhaaffkappppaaaafdeieefclaagaaaaeaaaabaakmabaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaad
pccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaa
acaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaagaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaagaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdejfeejepeo
aaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
// Stats: 48 math, 5 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_14;
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_8 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_8.zw;
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_14;
  vec3 x2_19;
  vec3 x1_20;
  x1_20.x = dot (unity_SHAr, tmpvar_18);
  x1_20.y = dot (unity_SHAg, tmpvar_18);
  x1_20.z = dot (unity_SHAb, tmpvar_18);
  vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x2_19.x = dot (unity_SHBr, tmpvar_21);
  x2_19.y = dot (unity_SHBg, tmpvar_21);
  x2_19.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_6.xyz = ((x2_19 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )) + x1_20);
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = o_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  float tmpvar_6;
  tmpvar_6 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_8;
  vec3 I_9;
  vec3 cse_10;
  cse_10 = -(xlv_TEXCOORD1);
  I_9 = -(cse_10);
  vec4 tmpvar_11;
  tmpvar_11.xyz = (I_9 - (2.0 * (
    dot (tmpvar_2, I_9)
   * tmpvar_2)));
  float cse_12;
  cse_12 = (1.0 - _Glossiness);
  tmpvar_11.w = (cse_12 * 7.0);
  vec4 tmpvar_13;
  tmpvar_13 = textureCube (unity_SpecCube0, tmpvar_11.xyz, tmpvar_11.w);
  tmpvar_8 = ((unity_SpecCube0_HDR.x * pow (tmpvar_13.w, unity_SpecCube0_HDR.y)) * tmpvar_13.xyz);
  tmpvar_8 = (tmpvar_8 * tmpvar_7.y);
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((cse_10 - (2.0 * 
    (dot (tmpvar_2, cse_10) * tmpvar_2)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_2, cse_10), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = (((tmpvar_14 * tmpvar_14) * tmpvar_14) * tmpvar_14);
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = cse_12;
  vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_4 + ((texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0) * tmpvar_5)) * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x))
   * 
    clamp (dot (tmpvar_2, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (xlv_TEXCOORD5.xyz * tmpvar_7.y)
   * tmpvar_4)) + (tmpvar_8 * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), tmpvar_15.yyy)));
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_17;
  c_1.w = tmpvar_18.w;
  c_1.xyz = tmpvar_17;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = c_1.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 47 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 21 [_DetailAlbedoMap_ST]
Vector 20 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Float 22 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 15 [unity_SHAb]
Vector 14 [unity_SHAg]
Vector 13 [unity_SHAr]
Vector 18 [unity_SHBb]
Vector 17 [unity_SHBg]
Vector 16 [unity_SHBr]
Vector 19 [unity_SHC]
"vs_2_0
def c23, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
mad oT0.xy, v2, c20, c20.zwzw
mul r0.x, c22.x, c22.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c21.xyxy, c21
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r0.xyz, r0, -c10
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c23.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c23.x
mad oT6.xy, r1.z, c12.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c16, r3
dp4 r4.y, c17, r3
dp4 r4.z, c18, r3
mad r1.xyz, c19, r1.x, r4
mov r2.w, c23.y
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mov oT4.xyz, r2
add oT5.xyz, r1, r3
dp4 r0.z, c2, v0
mov oPos, r0
mov oT6.zw, r0
mov oT2, c23.z
mov oT3, c23.z
mov oT4.w, c23.z
mov oT5.w, c23.z

"
}
SubProgram "d3d11 " {
// Stats: 43 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedannffpohonncgmijciindnbicnjlhjccabaaaaaapaaiaaaaadaaaaaa
cmaaaaaaliaaaaaakaabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefceiahaaaaeaaaabaancabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaa
ahaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaa
abaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaa
abaaaaaaagaabaaaabaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaal
mccabaaaabaaaaaaagaebaaaabaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaa
aaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaai
pccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
pccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaafaaaaaa
abeaaaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaiaebaaaaaaacaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaa
egakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaa
agaabaaaacaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
abaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
abaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
abaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
dgaaaaaficcabaaaagaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 47 math, 4 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_14;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14;
  vec3 x2_16;
  vec3 x1_17;
  x1_17.x = dot (unity_SHAr, tmpvar_15);
  x1_17.y = dot (unity_SHAg, tmpvar_15);
  x1_17.z = dot (unity_SHAb, tmpvar_15);
  vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x2_16.x = dot (unity_SHBr, tmpvar_18);
  x2_16.y = dot (unity_SHBg, tmpvar_18);
  x2_16.z = dot (unity_SHBb, tmpvar_18);
  tmpvar_6.xyz = ((x2_16 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )) + x1_17);
  vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_7.x);
  vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_7.y);
  vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_7.z);
  vec4 tmpvar_22;
  tmpvar_22 = (((tmpvar_19 * tmpvar_19) + (tmpvar_20 * tmpvar_20)) + (tmpvar_21 * tmpvar_21));
  vec4 tmpvar_23;
  tmpvar_23 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_19 * tmpvar_14.x) + (tmpvar_20 * tmpvar_14.y)) + (tmpvar_21 * tmpvar_14.z))
   * 
    inversesqrt(tmpvar_22)
  )) * (1.0/((1.0 + 
    (tmpvar_22 * unity_4LightAtten0)
  ))));
  tmpvar_6.xyz = (tmpvar_6.xyz + ((
    ((unity_LightColor[0].xyz * tmpvar_23.x) + (unity_LightColor[1].xyz * tmpvar_23.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_23.z)
  ) + (unity_LightColor[3].xyz * tmpvar_23.w)));
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  float tmpvar_6;
  tmpvar_6 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_8;
  vec3 I_9;
  vec3 cse_10;
  cse_10 = -(xlv_TEXCOORD1);
  I_9 = -(cse_10);
  vec4 tmpvar_11;
  tmpvar_11.xyz = (I_9 - (2.0 * (
    dot (tmpvar_2, I_9)
   * tmpvar_2)));
  float cse_12;
  cse_12 = (1.0 - _Glossiness);
  tmpvar_11.w = (cse_12 * 7.0);
  vec4 tmpvar_13;
  tmpvar_13 = textureCube (unity_SpecCube0, tmpvar_11.xyz, tmpvar_11.w);
  tmpvar_8 = ((unity_SpecCube0_HDR.x * pow (tmpvar_13.w, unity_SpecCube0_HDR.y)) * tmpvar_13.xyz);
  tmpvar_8 = (tmpvar_8 * tmpvar_7.y);
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((cse_10 - (2.0 * 
    (dot (tmpvar_2, cse_10) * tmpvar_2)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_2, cse_10), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = (((tmpvar_14 * tmpvar_14) * tmpvar_14) * tmpvar_14);
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = cse_12;
  vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_4 + ((texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0) * tmpvar_5)) * _LightColor0.xyz)
   * 
    clamp (dot (tmpvar_2, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (xlv_TEXCOORD5.xyz * tmpvar_7.y)
   * tmpvar_4)) + (tmpvar_8 * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), tmpvar_15.yyy)));
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_17;
  c_1.w = tmpvar_18.w;
  c_1.xyz = tmpvar_17;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = c_1.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 68 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 27 [_DetailAlbedoMap_ST]
Vector 26 [_MainTex_ST]
Float 28 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 18 [unity_4LightAtten0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 21 [unity_SHAb]
Vector 20 [unity_SHAg]
Vector 19 [unity_SHAr]
Vector 24 [unity_SHBb]
Vector 23 [unity_SHBg]
Vector 22 [unity_SHBr]
Vector 25 [unity_SHC]
"vs_2_0
def c29, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dp4 oPos.x, c4, v0
dp4 oPos.y, c5, v0
dp4 oPos.z, c6, v0
dp4 oPos.w, c7, v0
mad oT0.xy, v2, c26, c26.zwzw
mul r0.x, c28.x, c28.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c27.xyxy, c27
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, r0, -c14
add r2, -r0.x, c15
add r3, -r0.y, c16
add r0, -r0.z, c17
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1, r3, r3
mad r1, r2, r2, r1
mad r1, r0, r0, r1
rsq r4.x, r1.x
rsq r4.y, r1.y
rsq r4.z, r1.z
rsq r4.w, r1.w
mov r5.x, c29.x
mad r1, r1, c18, r5.x
mul r5.xyz, v1.y, c12
mad r5.xyz, c11, v1.x, r5
mad r5.xyz, c13, v1.z, r5
nrm r6.xyz, r5
mul r3, r3, r6.y
mad r2, r2, r6.x, r3
mad r0, r0, r6.z, r2
mul r0, r4, r0
max r0, r0, c29.y
rcp r2.x, r1.x
rcp r2.y, r1.y
rcp r2.z, r1.z
rcp r2.w, r1.w
mul r0, r0, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r6.y, r6.y
mad r0.w, r6.x, r6.x, -r0.w
mul r1, r6.yzzx, r6.xyzz
dp4 r2.x, c22, r1
dp4 r2.y, c23, r1
dp4 r2.z, c24, r1
mad r1.xyz, c25, r0.w, r2
mov r6.w, c29.x
dp4 r2.x, c19, r6
dp4 r2.y, c20, r6
dp4 r2.z, c21, r6
mov oT4.xyz, r6
add r1.xyz, r1, r2
add oT5.xyz, r0, r1
mov oT2, c29.y
mov oT3, c29.y
mov oT4.w, c29.y
mov oT5.w, c29.y

"
}
SubProgram "d3d11 " {
// Stats: 60 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedaiolnalokeioglpllfodlkafjibalehaabaaaaaapiakaaaaadaaaaaa
cmaaaaaaliaaaaaaiiabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcgiajaaaaeaaaabaafkacaaaafjaaaaaeegiocaaa
aaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
hccabaaaafaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaaaaaaaaakgakbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaa
aaaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaa
egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
dgaaaaaficcabaaaagaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 60 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedfkhcgnompgiahpgcjlgcamnjmobcbbdaabaaaaaajebaaaaaaeaaaaaa
daaaaaaamiafaaaadiapaaaameapaaaaebgpgodjjaafaaaajaafaaaaaaacpopp
beafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaacaaaiaaafaaaaaaaaaaacaacgaaahaaanaaaaaaaaaaadaaaaaaaeaabeaa
aaaaaaaaadaaamaaahaabiaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbpaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaacaaoejaabaaoekaabaaookaafaaaaadaaaaabiaadaakkka
adaakkkaanaaaaadaaaaabiaaaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoeja
bcaaaaaeacaaadiaaaaaaaiaabaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeia
acaaeekaacaaoekaafaaaaadaaaaahiaaaaaffjabjaaoekaaeaaaaaeaaaaahia
biaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabkaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiablaaoekaaaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeia
aeaaoekbaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadabaaahoaaaaappiaabaaoeiaacaaaaadabaaapiaaaaaaaibafaaoeka
acaaaaadacaaapiaaaaaffibagaaoekaacaaaaadaaaaapiaaaaakkibahaaoeka
afaaaaadadaaabiaabaaaajabmaaaakaafaaaaadadaaaciaabaaaajabnaaaaka
afaaaaadadaaaeiaabaaaajaboaaaakaafaaaaadaeaaabiaabaaffjabmaaffka
afaaaaadaeaaaciaabaaffjabnaaffkaafaaaaadaeaaaeiaabaaffjaboaaffka
acaaaaadadaaahiaadaaoeiaaeaaoeiaafaaaaadaeaaabiaabaakkjabmaakkka
afaaaaadaeaaaciaabaakkjabnaakkkaafaaaaadaeaaaeiaabaakkjaboaakkka
acaaaaadadaaahiaadaaoeiaaeaaoeiaceaaaaacaeaaahiaadaaoeiaafaaaaad
adaaapiaacaaoeiaaeaaffiaafaaaaadacaaapiaacaaoeiaacaaoeiaaeaaaaae
acaaapiaabaaoeiaabaaoeiaacaaoeiaaeaaaaaeabaaapiaabaaoeiaaeaaaaia
adaaoeiaaeaaaaaeabaaapiaaaaaoeiaaeaakkiaabaaoeiaaeaaaaaeaaaaapia
aaaaoeiaaaaaoeiaacaaoeiaahaaaaacacaaabiaaaaaaaiaahaaaaacacaaacia
aaaaffiaahaaaaacacaaaeiaaaaakkiaahaaaaacacaaaiiaaaaappiaabaaaaac
adaaabiabpaaaakaaeaaaaaeaaaaapiaaaaaoeiaaiaaoekaadaaaaiaafaaaaad
abaaapiaabaaoeiaacaaoeiaalaaaaadabaaapiaabaaoeiabpaaffkaagaaaaac
acaaabiaaaaaaaiaagaaaaacacaaaciaaaaaffiaagaaaaacacaaaeiaaaaakkia
agaaaaacacaaaiiaaaaappiaafaaaaadaaaaapiaabaaoeiaacaaoeiaafaaaaad
abaaahiaaaaaffiaakaaoekaaeaaaaaeabaaahiaajaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiaalaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiaamaaoeka
aaaappiaaaaaoeiaafaaaaadaaaaaiiaaeaaffiaaeaaffiaaeaaaaaeaaaaaiia
aeaaaaiaaeaaaaiaaaaappibafaaaaadabaaapiaaeaacjiaaeaakeiaajaaaaad
acaaabiabaaaoekaabaaoeiaajaaaaadacaaaciabbaaoekaabaaoeiaajaaaaad
acaaaeiabcaaoekaabaaoeiaaeaaaaaeabaaahiabdaaoekaaaaappiaacaaoeia
abaaaaacaeaaaiiabpaaaakaajaaaaadacaaabiaanaaoekaaeaaoeiaajaaaaad
acaaaciaaoaaoekaaeaaoeiaajaaaaadacaaaeiaapaaoekaaeaaoeiaabaaaaac
aeaaahoaaeaaoeiaacaaaaadabaaahiaabaaoeiaacaaoeiaacaaaaadafaaahoa
aaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabfaaoekaaeaaaaaeaaaaapia
beaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabgaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiabhaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaapoabpaaffka
abaaaaacadaaapoabpaaffkaabaaaaacaeaaaioabpaaffkaabaaaaacafaaaioa
bpaaffkappppaaaafdeieefcgiajaaaaeaaaabaafkacaaaafjaaaaaeegiocaaa
aaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
hccabaaaafaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaaaaaaaaakgakbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaa
aaaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaa
egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
dgaaaaaficcabaaaagaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
hbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfcee
aaklklklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 48 math, 5 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = tmpvar_14;
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_8 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_8.zw;
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_14;
  vec3 x2_19;
  vec3 x1_20;
  x1_20.x = dot (unity_SHAr, tmpvar_18);
  x1_20.y = dot (unity_SHAg, tmpvar_18);
  x1_20.z = dot (unity_SHAb, tmpvar_18);
  vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x2_19.x = dot (unity_SHBr, tmpvar_21);
  x2_19.y = dot (unity_SHBg, tmpvar_21);
  x2_19.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_6.xyz = ((x2_19 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )) + x1_20);
  vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_7.x);
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_7.y);
  vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_7.z);
  vec4 tmpvar_25;
  tmpvar_25 = (((tmpvar_22 * tmpvar_22) + (tmpvar_23 * tmpvar_23)) + (tmpvar_24 * tmpvar_24));
  vec4 tmpvar_26;
  tmpvar_26 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_22 * tmpvar_14.x) + (tmpvar_23 * tmpvar_14.y)) + (tmpvar_24 * tmpvar_14.z))
   * 
    inversesqrt(tmpvar_25)
  )) * (1.0/((1.0 + 
    (tmpvar_25 * unity_4LightAtten0)
  ))));
  tmpvar_6.xyz = (tmpvar_6.xyz + ((
    ((unity_LightColor[0].xyz * tmpvar_26.x) + (unity_LightColor[1].xyz * tmpvar_26.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_26.z)
  ) + (unity_LightColor[3].xyz * tmpvar_26.w)));
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = o_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  float tmpvar_6;
  tmpvar_6 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_8;
  vec3 I_9;
  vec3 cse_10;
  cse_10 = -(xlv_TEXCOORD1);
  I_9 = -(cse_10);
  vec4 tmpvar_11;
  tmpvar_11.xyz = (I_9 - (2.0 * (
    dot (tmpvar_2, I_9)
   * tmpvar_2)));
  float cse_12;
  cse_12 = (1.0 - _Glossiness);
  tmpvar_11.w = (cse_12 * 7.0);
  vec4 tmpvar_13;
  tmpvar_13 = textureCube (unity_SpecCube0, tmpvar_11.xyz, tmpvar_11.w);
  tmpvar_8 = ((unity_SpecCube0_HDR.x * pow (tmpvar_13.w, unity_SpecCube0_HDR.y)) * tmpvar_13.xyz);
  tmpvar_8 = (tmpvar_8 * tmpvar_7.y);
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((cse_10 - (2.0 * 
    (dot (tmpvar_2, cse_10) * tmpvar_2)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_2, cse_10), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = (((tmpvar_14 * tmpvar_14) * tmpvar_14) * tmpvar_14);
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = cse_12;
  vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_4 + ((texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0) * tmpvar_5)) * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x))
   * 
    clamp (dot (tmpvar_2, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (xlv_TEXCOORD5.xyz * tmpvar_7.y)
   * tmpvar_4)) + (tmpvar_8 * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), tmpvar_15.yyy)));
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_17;
  c_1.w = tmpvar_18.w;
  c_1.xyz = tmpvar_17;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = c_1.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 74 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 29 [_DetailAlbedoMap_ST]
Vector 28 [_MainTex_ST]
Vector 15 [_ProjectionParams]
Vector 16 [_ScreenParams]
Float 30 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 20 [unity_4LightAtten0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 23 [unity_SHAb]
Vector 22 [unity_SHAg]
Vector 21 [unity_SHAr]
Vector 26 [unity_SHBb]
Vector 25 [unity_SHBg]
Vector 24 [unity_SHBr]
Vector 27 [unity_SHC]
"vs_2_0
def c31, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
mad oT0.xy, v2, c28, c28.zwzw
mul r0.x, c30.x, c30.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c29.xyxy, c29
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, r0, -c14
add r2, -r0.x, c17
add r3, -r0.y, c18
add r0, -r0.z, c19
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
dp4 r1.y, c5, v0
mul r4.x, r1.y, c15.x
mul r4.w, r4.x, c31.x
dp4 r1.x, c4, v0
dp4 r1.w, c7, v0
mul r4.xz, r1.xyww, c31.x
mad oT6.xy, r4.z, c16.zwzw, r4.xwzw
mul r4, r3, r3
mad r4, r2, r2, r4
mad r4, r0, r0, r4
rsq r5.x, r4.x
rsq r5.y, r4.y
rsq r5.z, r4.z
rsq r5.w, r4.w
mov r6.y, c31.y
mad r4, r4, c20, r6.y
mul r6.xyz, v1.y, c12
mad r6.xyz, c11, v1.x, r6
mad r6.xyz, c13, v1.z, r6
nrm r7.xyz, r6
mul r3, r3, r7.y
mad r2, r2, r7.x, r3
mad r0, r0, r7.z, r2
mul r0, r5, r0
max r0, r0, c31.z
rcp r2.x, r4.x
rcp r2.y, r4.y
rcp r2.z, r4.z
rcp r2.w, r4.w
mul r0, r0, r2
mul r2.xyz, r0.y, c1
mad r2.xyz, c0, r0.x, r2
mad r0.xyz, c2, r0.z, r2
mad r0.xyz, c3, r0.w, r0
mul r0.w, r7.y, r7.y
mad r0.w, r7.x, r7.x, -r0.w
mul r2, r7.yzzx, r7.xyzz
dp4 r3.x, c24, r2
dp4 r3.y, c25, r2
dp4 r3.z, c26, r2
mad r2.xyz, c27, r0.w, r3
mov r7.w, c31.y
dp4 r3.x, c21, r7
dp4 r3.y, c22, r7
dp4 r3.z, c23, r7
mov oT4.xyz, r7
add r2.xyz, r2, r3
add oT5.xyz, r0, r2
dp4 r1.z, c6, v0
mov oPos, r1
mov oT6.zw, r1
mov oT2, c31.z
mov oT3, c31.z
mov oT4.w, c31.z
mov oT5.w, c31.z

"
}
SubProgram "d3d11 " {
// Stats: 63 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedmjmiooiocnebpohniinnnfgbnpfecgolabaaaaaakialaaaaadaaaaaa
cmaaaaaaliaaaaaakaabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcaaakaaaaeaaaabaaiaacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaa
ahaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaa
abaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaa
abaaaaaaagaabaaaabaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaal
mccabaaaabaaaaaaagaebaaaabaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaa
aaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaai
pccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
pccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaf
iccabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaaafaaaaaa
egacbaaaacaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaa
acaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaacaaaaaa
egakbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaabaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaa
aaaaaaajpcaabaaaaeaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaaj
pcaabaaaagaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaaacaaaaaaacaaaaaa
aaaaaaajpcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaaacaaaaaa
aeaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaacaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaabaaaaaakgakbaaa
acaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaa
egaobaaaagaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaa
egaobaaaabaaaaaadcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaa
acaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaak
pcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
deaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaa
ahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaah
hccabaaaagaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficcabaaa
agaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 48 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0_level_9_1
eefiecedbccfdcbjbidadpfoipgeoaboppnlmhpdabaaaaaacmaoaaaaaeaaaaaa
daaaaaaaleaeaaaaliamaaaaeeanaaaaebgpgodjhmaeaaaahmaeaaaaaaacpopp
aaaeaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaacgaaahaaafaaaaaaaaaaadaaaiaaaeaaamaaaaaaaaaaaeaaaaaaaeaabaaa
aaaaaaaaaeaaamaaahaabeaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafblaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaacaaoejaabaaoekaabaaookaafaaaaadaaaaabiaadaakkka
adaakkkaanaaaaadaaaaabiaaaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoeja
bcaaaaaeacaaadiaaaaaaaiaabaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeia
acaaeekaacaaoekaafaaaaadaaaaahiaaaaaffjabfaaoekaaeaaaaaeaaaaahia
beaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabgaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabhaaoekaaaaappjaaaaaoeiaacaaaaadaaaaahiaaaaaoeia
aeaaoekbaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappia
afaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjabfaaoeka
aeaaaaaeaaaaapiabeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabgaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaappjaaaaaoeiaafaaaaad
abaaapiaaaaaffiaanaaoekaaeaaaaaeabaaapiaamaaoekaaaaaaaiaabaaoeia
aeaaaaaeabaaapiaaoaaoekaaaaakkiaabaaoeiaaeaaaaaeagaaapoaapaaoeka
aaaappiaabaaoeiaafaaaaadaaaaabiaabaaaajabiaaaakaafaaaaadaaaaacia
abaaaajabjaaaakaafaaaaadaaaaaeiaabaaaajabkaaaakaafaaaaadabaaabia
abaaffjabiaaffkaafaaaaadabaaaciaabaaffjabjaaffkaafaaaaadabaaaeia
abaaffjabkaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabia
abaakkjabiaakkkaafaaaaadabaaaciaabaakkjabjaakkkaafaaaaadabaaaeia
abaakkjabkaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahia
aaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaia
abaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeiaajaaaaadadaaabia
aiaaoekaacaaoeiaajaaaaadadaaaciaajaaoekaacaaoeiaajaaaaadadaaaeia
akaaoekaacaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaaaaiaadaaoeiaabaaaaac
abaaaiiablaaaakaajaaaaadacaaabiaafaaoekaabaaoeiaajaaaaadacaaacia
agaaoekaabaaoeiaajaaaaadacaaaeiaahaaoekaabaaoeiaabaaaaacaeaaahoa
abaaoeiaacaaaaadafaaahoaaaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffja
bbaaoekaaeaaaaaeaaaaapiabaaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bcaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoablaaffkaabaaaaacadaaapoablaaffkaabaaaaacaeaaaioa
blaaffkaabaaaaacafaaaioablaaffkappppaaaafdeieefcpmahaaaaeaaaabaa
ppabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
amaaaaaafjaaaaaeegiocaaaaeaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaad
pccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaa
acaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaeaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaabaaaaaa
akiacaaaaeaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaabaaaaaa
bkiacaaaaeaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaabaaaaaackiacaaa
aeaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaagaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaagaaaaaaabeaaaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaadaaaaaa
alaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
hbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfcee
aaklklklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "d3d11_9x " {
// Stats: 68 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0_level_9_1
eefiecedkfgmgfndekmhdngcpnjpjefpdiihflkjabaaaaaajmbcaaaaaeaaaaaa
daaaaaaagmagaaaacibbaaaalebbaaaaebgpgodjdeagaaaadeagaaaaaaacpopp
kmafaaaaiiaaaaaaaiaaceaaaaaaieaaaaaaieaaaaaaceaaabaaieaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaacaaaiaaafaaaaaaaaaaacaacgaaahaaanaaaaaaaaaaadaaaiaaaeaabeaa
aaaaaaaaaeaaaaaaaeaabiaaaaaaaaaaaeaaamaaahaabmaaaaaaaaaaaaaaaaaa
aaacpoppfbaaaaafcdaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaacaaoejaabaaoekaabaaooka
afaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabiaaaaaaaibaaaaaaia
abaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaiaabaaoeiaadaaoeja
aeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaadaaaaahiaaaaaffja
bnaaoekaaeaaaaaeaaaaahiabmaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahia
boaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabpaaoekaaaaappjaaaaaoeia
acaaaaadabaaahiaaaaaoeiaaeaaoekbaiaaaaadaaaaaiiaabaaoeiaabaaoeia
ahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoaaaaappiaabaaoeiaafaaaaad
abaaapiaaaaaffjabnaaoekaaeaaaaaeabaaapiabmaaoekaaaaaaajaabaaoeia
aeaaaaaeabaaapiaboaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaapiabpaaoeka
aaaappjaabaaoeiaafaaaaadacaaapiaabaaffiabfaaoekaaeaaaaaeacaaapia
beaaoekaabaaaaiaacaaoeiaaeaaaaaeacaaapiabgaaoekaabaakkiaacaaoeia
aeaaaaaeagaaapoabhaaoekaabaappiaacaaoeiaacaaaaadabaaapiaaaaaaaib
afaaoekaacaaaaadacaaapiaaaaaffibagaaoekaacaaaaadaaaaapiaaaaakkib
ahaaoekaafaaaaadadaaabiaabaaaajacaaaaakaafaaaaadadaaaciaabaaaaja
cbaaaakaafaaaaadadaaaeiaabaaaajaccaaaakaafaaaaadaeaaabiaabaaffja
caaaffkaafaaaaadaeaaaciaabaaffjacbaaffkaafaaaaadaeaaaeiaabaaffja
ccaaffkaacaaaaadadaaahiaadaaoeiaaeaaoeiaafaaaaadaeaaabiaabaakkja
caaakkkaafaaaaadaeaaaciaabaakkjacbaakkkaafaaaaadaeaaaeiaabaakkja
ccaakkkaacaaaaadadaaahiaadaaoeiaaeaaoeiaceaaaaacaeaaahiaadaaoeia
afaaaaadadaaapiaacaaoeiaaeaaffiaafaaaaadacaaapiaacaaoeiaacaaoeia
aeaaaaaeacaaapiaabaaoeiaabaaoeiaacaaoeiaaeaaaaaeabaaapiaabaaoeia
aeaaaaiaadaaoeiaaeaaaaaeabaaapiaaaaaoeiaaeaakkiaabaaoeiaaeaaaaae
aaaaapiaaaaaoeiaaaaaoeiaacaaoeiaahaaaaacacaaabiaaaaaaaiaahaaaaac
acaaaciaaaaaffiaahaaaaacacaaaeiaaaaakkiaahaaaaacacaaaiiaaaaappia
abaaaaacadaaabiacdaaaakaaeaaaaaeaaaaapiaaaaaoeiaaiaaoekaadaaaaia
afaaaaadabaaapiaabaaoeiaacaaoeiaalaaaaadabaaapiaabaaoeiacdaaffka
agaaaaacacaaabiaaaaaaaiaagaaaaacacaaaciaaaaaffiaagaaaaacacaaaeia
aaaakkiaagaaaaacacaaaiiaaaaappiaafaaaaadaaaaapiaabaaoeiaacaaoeia
afaaaaadabaaahiaaaaaffiaakaaoekaaeaaaaaeabaaahiaajaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahia
amaaoekaaaaappiaaaaaoeiaafaaaaadaaaaaiiaaeaaffiaaeaaffiaaeaaaaae
aaaaaiiaaeaaaaiaaeaaaaiaaaaappibafaaaaadabaaapiaaeaacjiaaeaakeia
ajaaaaadacaaabiabaaaoekaabaaoeiaajaaaaadacaaaciabbaaoekaabaaoeia
ajaaaaadacaaaeiabcaaoekaabaaoeiaaeaaaaaeabaaahiabdaaoekaaaaappia
acaaoeiaabaaaaacaeaaaiiacdaaaakaajaaaaadacaaabiaanaaoekaaeaaoeia
ajaaaaadacaaaciaaoaaoekaaeaaoeiaajaaaaadacaaaeiaapaaoekaaeaaoeia
abaaaaacaeaaahoaaeaaoeiaacaaaaadabaaahiaabaaoeiaacaaoeiaacaaaaad
afaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabjaaoekaaeaaaaae
aaaaapiabiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabkaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiablaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaapoa
cdaaffkaabaaaaacadaaapoacdaaffkaabaaaaacaeaaaioacdaaffkaabaaaaac
afaaaioacdaaffkappppaaaafdeieefcleakaaaaeaaaabaaknacaaaafjaaaaae
egiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaae
egiocaaaaeaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaipccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaaabeaaaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabcaaaaaadiaaaaaibcaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
ckbabaaaabaaaaaackiacaaaaeaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
hccabaaaafaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaaaaaaaaakgakbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaa
agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaa
aaaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaa
egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
dgaaaaaficcabaaaagaaaaaaabeaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaahaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hiaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafaepfdejfeejepeo
aaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 45 math, 4 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 4 [_Color]
Float 6 [_Glossiness]
Vector 3 [_LightColor0]
Float 5 [_Metallic]
Vector 0 [_WorldSpaceLightPos0]
Vector 2 [unity_ColorSpaceDielectricSpec]
Vector 1 [unity_SpecCube0_HDR]
SetTexture 0 [unity_SpecCube0] CUBE 0
SetTexture 1 [unity_NHxRoughness] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_OcclusionMap] 2D 3
"ps_2_0
def c7, -7, 7, 1, 16
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t4.xyz
dcl_pp t5.xyz
dcl_cube s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
nrm_pp r0.xyz, t4
dp3_pp r0.w, -t1, r0
add_pp r1.w, r0.w, r0.w
mov_sat_pp r0.w, r0.w
add_pp r1.y, -r0.w, c7.z
mad_pp r2.xyz, r0, -r1.w, -t1
dp3_pp r1.x, r2, c0
mul_pp r1.xy, r1, r1
mul_pp r1.xy, r1, r1
mov r2.xyz, c7
add_pp r1.z, r2.z, -c6.x
mov_pp r3.x, r1.x
mov_pp r3.y, r1.z
dp3 r0.w, t1, r0
add r0.w, r0.w, r0.w
mad_pp r4.xyz, r0, -r0.w, t1
mad_pp r4.w, c6.x, r2.x, r2.y
texld r2, r3, s1
texld r3, t0, s2
texld_pp r5, t0, s3
texldb_pp r4, r4, s0
mul_pp r0.w, r2.x, c7.w
mov r2, c2
mad_pp r6.xyz, c4, r3, -r2
mul_pp r3.xyz, r3, c4
mad_pp r2.xyz, c5.x, r6, r2
mad_pp r2.w, c5.x, -r2.w, r2.w
mul_pp r3.xyz, r2.w, r3
add_pp r2.w, -r2.w, c6.x
add_sat_pp r2.w, r2.w, c7.z
lrp_pp r6.xyz, r1.y, r2.w, r2
mad_pp r1.xyz, r0.w, r2, r3
mul_pp r1.xyz, r1, c3
mul_pp r2.xyz, r5.y, t5
mul_pp r2.xyz, r3, r2
dp3_sat_pp r1.w, r0, c0
mad_pp r0.xyz, r1, r1.w, r2
pow_pp r0.w, r4.w, c1.y
mul_pp r0.w, r0.w, c1.x
mul_pp r1.xyz, r4, r0.w
mul_pp r1.xyz, r5.y, r1
mad_pp r0.xyz, r1, r6, r0
mov_pp r0.w, c7.z
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 38 math, 3 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_OcclusionMap] 2D 3
SetTexture 2 [unity_NHxRoughness] 2D 1
SetTexture 3 [unity_SpecCube0] CUBE 0
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityReflectionProbes" 128
Vector 48 [unity_SpecCube0_HDR]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityReflectionProbes" 2
"ps_4_0
eefieceddcaefbdbodbopnomlddiiaffnnmjbdceabaaaaaalaahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchiagaaaaeaaaaaaajoabaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaia
ebaaaaaaacaaaaaaegacbaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaaiccaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaalhcaabaaaabaaaaaaegacbaaaaaaaaaaaagaabaiaebaaaaaaabaaaaaa
egbcbaiaebaaaaaaacaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaabaaaaaaaaaaaaaadiaaaaahdcaabaaaabaaaaaaegaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaahgcaabaaaabaaaaaaagabbaaaabaaaaaaagabbaaa
abaaaaaaaaaaaaamjcaabaaaabaaaaaapgipcaiaebaaaaaaaaaaaaaaanaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
ngafbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaoaeadiaaaaahbcaabaaaabaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaadaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaaacaaaaaa
egiccaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaanccaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaadaaaaaafgafbaaaabaaaaaaegacbaaaadaaaaaa
aaaaaaajccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadkiacaaaaaaaaaaa
anaaaaaaaacaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaihcaabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaafgafbaaaabaaaaaa
dcaaaaajocaabaaaabaaaaaakgakbaaaabaaaaaaagajbaaaaeaaaaaaagajbaaa
acaaaaaadcaaaaajhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadiaaaaahncaabaaaaeaaaaaafgafbaaaaeaaaaaa
agbjbaaaagaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaigadbaaa
aeaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaiaebaaaaaaabaaaaaa
egbcbaaaacaaaaaaeiaaaaalpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaadkaabaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaa
acaaaaaaadaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaacaaaaaaadaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaafgafbaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 35 math, 3 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_OcclusionMap] 2D 3
SetTexture 2 [unity_SpecCube0] CUBE 0
SetTexture 3 [unity_NHxRoughness] 2D 1
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityReflectionProbes" 128
Vector 48 [unity_SpecCube0_HDR]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityReflectionProbes" 2
"ps_4_0_level_9_1
eefiecedadnhifkfelphchnmmaomicmmdfegebjgabaaaaaacialaaaaaeaaaaaa
daaaaaaaomadaaaaceakaaaapeakaaaaebgpgodjleadaaaaleadaaaaaaacpppp
diadaaaahmaaaaaaagaadeaaaaaahmaaaaaahmaaaeaaceaaaaaahmaaacaaaaaa
adababaaaaacacaaabadadaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaaabaaabaa
aaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaaabaaaaaa
abaaaeaaaaaaaaaaacaaadaaabaaafaaaaaaaaaaaaacppppfbaaaaafagaaapka
aaaaoamaaaaaoaeaaaaaiadpaaaaiaebbpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaaiaafaacpla
bpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkaceaaaaacaaaachiaaeaaoelaaiaaaaad
aaaaciiaabaaoelbaaaaoeiaacaaaaadabaaciiaaaaappiaaaaappiaabaaaaac
aaaadiiaaaaappiaacaaaaadabaacciaaaaappibagaakkkaaeaaaaaeacaachia
aaaaoeiaabaappibabaaoelbaiaaaaadabaacbiaacaaoeiaaeaaoekaafaaaaad
abaacdiaabaaoeiaabaaoeiaafaaaaadabaacdiaabaaoeiaabaaoeiaabaaaaac
acaaamiaadaaoekaacaaaaadabaaceiaacaappibagaakkkaabaaaaacacaacbia
abaaaaiaabaaaaacacaacciaabaakkiaaiaaaaadaaaaaiiaabaaoelaaaaaoeia
acaaaaadaaaaaiiaaaaappiaaaaappiaaeaaaaaeadaachiaaaaaoeiaaaaappib
abaaoelaaeaaaaaeadaaciiaacaappiaagaaaakaagaaffkaecaaaaadaeaaapia
acaaoeiaabaioekaecaaaaadafaaapiaaaaaoelaacaioekaecaaaaadagaacpia
aaaaoelaadaioekaecaaacadadaacpiaadaaoeiaaaaioekaafaaaaadaaaaciia
aeaaaaiaagaappkaabaaaaacaeaaahiaaaaaoekaaeaaaaaeaeaachiaacaaoeka
afaaoeiaaeaaoeibafaaaaadafaachiaafaaoeiaacaaoekaaeaaaaaeaeaachia
acaakkiaaeaaoeiaaaaaoekaaeaaaaaeaeaaciiaacaakkiaaaaappkbaaaappka
afaaaaadacaachiaaeaappiaafaaoeiaacaaaaadacaaciiaaeaappibadaappka
acaaaaadacaadiiaacaappiaagaakkkabcaaaaaeafaachiaabaaffiaacaappia
aeaaoeiaaeaaaaaeabaachiaaaaappiaaeaaoeiaacaaoeiaafaaaaadabaachia
abaaoeiaabaaoekaafaaaaadaeaachiaagaaffiaafaaoelaafaaaaadacaachia
acaaoeiaaeaaoeiaaiaaaaadabaadiiaaaaaoeiaaeaaoekaaeaaaaaeaaaachia
abaaoeiaabaappiaacaaoeiaafaaaaadaaaaciiaadaappiaafaaaakaafaaaaad
abaachiaadaaoeiaaaaappiaafaaaaadabaachiaagaaffiaabaaoeiaaeaaaaae
aaaachiaabaaoeiaafaaoeiaaaaaoeiaabaaaaacaaaaciiaagaakkkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcdaagaaaaeaaaaaaaimabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaai
ccaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
hcaabaaaabaaaaaaegacbaaaaaaaaaaaagaabaiaebaaaaaaabaaaaaaegbcbaia
ebaaaaaaacaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
abaaaaaaaaaaaaaadiaaaaahdcaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaa
acaaaaaadiaaaaahgcaabaaaabaaaaaaagabbaaaabaaaaaaagabbaaaabaaaaaa
aaaaaaamjcaabaaaabaaaaaapgipcaiaebaaaaaaaaaaaaaaanaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaoaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaa
aaaaaaaaajaaaaaaegacbaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaacaaaaaadcaaaaanccaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaafgafbaaaabaaaaaaegacbaaaadaaaaaaaaaaaaaj
ccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
aacaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
hcaabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaafgafbaaaabaaaaaadcaaaaaj
ocaabaaaabaaaaaakgakbaaaabaaaaaaagajbaaaaeaaaaaaagajbaaaacaaaaaa
dcaaaaajhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
agaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadiaaaaahncaabaaaaeaaaaaafgafbaaaaeaaaaaaagbjbaaa
agaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaigadbaaaaeaaaaaa
bacaaaaibcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
aaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaiaebaaaaaaabaaaaaaegbcbaaa
acaaaaaaekaaaaalpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaaaacaaaaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaafgafbaaaaeaaaaaa
egacbaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 46 math, 5 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 4 [_Color]
Float 6 [_Glossiness]
Vector 3 [_LightColor0]
Float 5 [_Metallic]
Vector 0 [_WorldSpaceLightPos0]
Vector 2 [unity_ColorSpaceDielectricSpec]
Vector 1 [unity_SpecCube0_HDR]
SetTexture 0 [unity_SpecCube0] CUBE 0
SetTexture 1 [unity_NHxRoughness] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_OcclusionMap] 2D 3
SetTexture 4 [_ShadowMapTexture] 2D 4
"ps_2_0
def c7, -7, 7, 1, 16
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t4.xyz
dcl_pp t5.xyz
dcl_pp t6
dcl_cube s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
nrm_pp r0.xyz, t4
dp3_pp r0.w, -t1, r0
add_pp r1.w, r0.w, r0.w
mov_sat_pp r0.w, r0.w
add_pp r1.y, -r0.w, c7.z
mad_pp r2.xyz, r0, -r1.w, -t1
dp3_pp r1.x, r2, c0
mul_pp r1.xy, r1, r1
mul_pp r1.xy, r1, r1
mov r2.xyz, c7
add_pp r1.z, r2.z, -c6.x
mov_pp r3.x, r1.x
mov_pp r3.y, r1.z
dp3 r0.w, t1, r0
add r0.w, r0.w, r0.w
mad_pp r4.xyz, r0, -r0.w, t1
mad_pp r4.w, c6.x, r2.x, r2.y
texldp_pp r2, t6, s4
texld r3, r3, s1
texld r5, t0, s2
texld_pp r6, t0, s3
texldb_pp r4, r4, s0
mul_pp r2.xyz, r2.x, c3
mul_pp r0.w, r3.x, c7.w
mov r3, c2
mad_pp r7.xyz, c4, r5, -r3
mul_pp r5.xyz, r5, c4
mad_pp r3.xyz, c5.x, r7, r3
mad_pp r2.w, c5.x, -r3.w, r3.w
mul_pp r5.xyz, r2.w, r5
add_pp r2.w, -r2.w, c6.x
add_sat_pp r2.w, r2.w, c7.z
lrp_pp r7.xyz, r1.y, r2.w, r3
mad_pp r1.xyz, r0.w, r3, r5
mul_pp r1.xyz, r2, r1
mul_pp r2.xyz, r6.y, t5
mul_pp r2.xyz, r5, r2
dp3_sat_pp r1.w, r0, c0
mad_pp r0.xyz, r1, r1.w, r2
pow_pp r0.w, r4.w, c1.y
mul_pp r0.w, r0.w, c1.x
mul_pp r1.xyz, r4, r0.w
mul_pp r1.xyz, r6.y, r1
mad_pp r0.xyz, r1, r7, r0
mov_pp r0.w, c7.z
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 40 math, 4 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_ShadowMapTexture] 2D 4
SetTexture 2 [_OcclusionMap] 2D 3
SetTexture 3 [unity_NHxRoughness] 2D 1
SetTexture 4 [unity_SpecCube0] CUBE 0
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityReflectionProbes" 128
Vector 48 [unity_SpecCube0_HDR]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityReflectionProbes" 2
"ps_4_0
eefiecedbjnpeajdganodifganidhkilmabfcapaabaaaaaaemaiaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpmagaaaaeaaaaaaalpabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadlcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaahaaaaaapgbpbaaaahaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaaiccaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaalhcaabaaaadaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaabaaaaaa
egbcbaiaebaaaaaaacaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaadaaaaaa
egiccaaaabaaaaaaaaaaaaaadiaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaahgcaabaaaacaaaaaaagabbaaaacaaaaaaagabbaaa
acaaaaaaaaaaaaamjcaabaaaacaaaaaapgipcaiaebaaaaaaaaaaaaaaanaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadpefaaaaajpcaabaaaadaaaaaa
ngafbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaoaeadiaaaaahicaabaaaabaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaailcaabaaaacaaaaaa
egaibaaaadaaaaaaegiicaaaaaaaaaaaajaaaaaadcaaaaamhcaabaaaadaaaaaa
egiccaaaaaaaaaaaajaaaaaaegacbaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaa
acaaaaaadcaaaaalhcaabaaaadaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaa
adaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaanicaabaaaadaaaaaackiacaia
ebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaa
acaaaaaadiaaaaahlcaabaaaacaaaaaaegambaaaacaaaaaapgapbaaaadaaaaaa
aaaaaaajicaabaaaadaaaaaadkaabaiaebaaaaaaadaaaaaadkiacaaaaaaaaaaa
anaaaaaaaacaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaiadp
aaaaaaaihcaabaaaaeaaaaaaegacbaiaebaaaaaaadaaaaaapgapbaaaadaaaaaa
dcaaaaajhcaabaaaaeaaaaaakgakbaaaacaaaaaaegacbaaaaeaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
egadbaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadiaaaaahncaabaaaadaaaaaafgafbaaaadaaaaaaagbjbaaa
agaaaaaadiaaaaahhcaabaaaacaaaaaaegadbaaaacaaaaaaigadbaaaadaaaaaa
bacaaaaiicaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaabaaaaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaabaaaaaaegbcbaaa
acaaaaaaeiaaaaalpcaabaaaabaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaadkaabaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaacaaaaaa
adaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaacaaaaaaadaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
fgafbaaaadaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 38 math, 3 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_OcclusionMap] 2D 3
SetTexture 2 [unity_SpecCube0] CUBE 0
SetTexture 3 [unity_NHxRoughness] 2D 1
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
ConstBuffer "UnityReflectionProbes" 128
Vector 48 [unity_SpecCube0_HDR]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityReflectionProbes" 3
"ps_4_0_level_9_1
eefiecedaoigggkeiiamjodeadcjkhncgpkdoipmabaaaaaahmamaaaaafaaaaaa
deaaaaaaemaeaaaafaalaaaagaalaaaaeiamaaaaebgpgodjbaaeaaaabaaeaaaa
aaacppppieadaaaaimaaaaaaahaadiaaaaaaimaaaaaaimaaafaaceaaaaaaimaa
apapaaaaacaaabaaadabacaaaaacadaaabadaeaaaaaaacaaabaaaaaaaaaaaaaa
aaaaagaaabaaabaaaaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaa
aaaaaaaaabaaaaaaabaaaeaaaaaaaaaaacaabiaaabaaafaaaaaaaaaaadaaadaa
abaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaiadpaaaaoamaaaaaoaea
aaaaiaebbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaaeaacplabpaaaaacaaaaaaiaafaacplabpaaaaacaaaaaaiaagaacpla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajiabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaceaaaaac
aaaachiaaeaaoelaaiaaaaadaaaaciiaabaaoelbaaaaoeiaacaaaaadabaaciia
aaaappiaaaaappiaabaaaaacaaaadiiaaaaappiaacaaaaadabaacciaaaaappib
ahaaaakaaeaaaaaeacaachiaaaaaoeiaabaappibabaaoelbaiaaaaadabaacbia
acaaoeiaaeaaoekaafaaaaadabaacdiaabaaoeiaabaaoeiaafaaaaadabaacdia
abaaoeiaabaaoeiaabaaaaacacaaahiaahaaoekaacaaaaadabaaceiaacaaaaia
adaappkbabaaaaacadaacbiaabaaaaiaabaaaaacadaacciaabaakkiaaiaaaaad
aaaaaiiaabaaoelaaaaaoeiaacaaaaadaaaaaiiaaaaappiaaaaappiaaeaaaaae
aeaachiaaaaaoeiaaaaappibabaaoelaaeaaaaaeaeaaciiaadaappkaacaaffia
acaakkiaecaaaaadafaacpiaagaaoelaaaaioekaecaaaaadadaaapiaadaaoeia
acaioekaecaaaaadagaaapiaaaaaoelaadaioekaecaaaaadahaacpiaaaaaoela
aeaioekaecaaacadaeaacpiaaeaaoeiaabaioekabcaaaaaeaaaaciiaafaaaaia
acaaaaiaafaaaakaafaaaaadacaachiaaaaappiaabaaoekaafaaaaadaaaaciia
adaaaaiaahaappkaabaaaaacadaaapiaaaaaoekaaeaaaaaeafaachiaacaaoeka
agaaoeiaadaaoeibafaaaaadagaachiaagaaoeiaacaaoekaaeaaaaaeadaachia
adaakkkaafaaoeiaadaaoeiaaeaaaaaeacaaciiaadaakkkaadaappibadaappia
afaaaaadafaachiaacaappiaagaaoeiaacaaaaadacaaciiaacaappibadaappka
acaaaaadacaadiiaacaappiaahaaaakabcaaaaaeagaachiaabaaffiaacaappia
adaaoeiaaeaaaaaeabaachiaaaaappiaadaaoeiaafaaoeiaafaaaaadabaachia
acaaoeiaabaaoeiaafaaaaadacaachiaahaaffiaafaaoelaafaaaaadacaachia
afaaoeiaacaaoeiaaiaaaaadabaadiiaaaaaoeiaaeaaoekaaeaaaaaeaaaachia
abaaoeiaabaappiaacaaoeiaafaaaaadaaaaciiaaeaappiaagaaaakaafaaaaad
abaachiaaeaaoeiaaaaappiaafaaaaadabaachiaahaaffiaabaaoeiaaeaaaaae
aaaachiaabaaoeiaagaaoeiaaaaaoeiaabaaaaacaaaaciiaahaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcpmagaaaaeaaaaaaalpabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaiaaadaagabaaaapaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
apaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaehaaaaalbcaabaaa
aaaaaaaaegbabaaaahaaaaaaaghabaaaapaaaaaaaagabaaaapaaaaaackbabaaa
ahaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaiaebaaaaaaacaaaaaabiaaaaaa
abeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaacaaaaaabiaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaai
icaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadgcaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaaiccaabaaaacaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaalhcaabaaaadaaaaaaegacbaaaabaaaaaa
pgapbaiaebaaaaaaabaaaaaaegbcbaiaebaaaaaaacaaaaaabaaaaaaibcaabaaa
acaaaaaaegacbaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaahdcaabaaa
acaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaahgcaabaaaacaaaaaa
agabbaaaacaaaaaaagabbaaaacaaaaaaaaaaaaamjcaabaaaacaaaaaapgipcaia
ebaaaaaaaaaaaaaaanaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadp
efaaaaajpcaabaaaadaaaaaangafbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaoaea
diaaaaahicaabaaaabaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiaebefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
diaaaaailcaabaaaacaaaaaaegaibaaaadaaaaaaegiicaaaaaaaaaaaajaaaaaa
dcaaaaamhcaabaaaadaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaaadaaaaaa
egiccaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaalhcaabaaaadaaaaaakgikcaaa
aaaaaaaaanaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaan
icaabaaaadaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaa
acaaaaaadkiacaaaaaaaaaaaacaaaaaadiaaaaahlcaabaaaacaaaaaaegambaaa
acaaaaaapgapbaaaadaaaaaaaaaaaaajicaabaaaadaaaaaadkaabaiaebaaaaaa
adaaaaaadkiacaaaaaaaaaaaanaaaaaaaacaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaiadpaaaaaaaihcaabaaaaeaaaaaaegacbaiaebaaaaaa
adaaaaaapgapbaaaadaaaaaadcaaaaajhcaabaaaaeaaaaaakgakbaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaaegadbaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahncaabaaaadaaaaaa
fgafbaaaadaaaaaaagbjbaaaagaaaaaadiaaaaahhcaabaaaacaaaaaaegadbaaa
acaaaaaaigadbaaaadaaaaaabacaaaaiicaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaabaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaia
ebaaaaaaabaaaaaaegbcbaaaacaaaaaaekaaaaalpcaabaaaabaaaaaaegacbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaabaaaaaaakiacaaaadaaaaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaafgafbaaaadaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaaiaaaaaaaaaaaaaaa
ejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaa
neaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapahaaaa
neaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapahaaaaneaaaaaaagaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 48 avg math (39..54)
 //    d3d11_9x : 49 avg math (39..54)
 //        d3d9 : 45 avg math (39..51)
 //      opengl : 32 avg math (28..40), 3 avg texture (2..5), 0 avg branch (0..1)
 // Stats for Fragment shader:
 //       d3d11 : 24 avg math (20..32), 3 avg texture (2..5)
 //    d3d11_9x : 25 avg math (20..32), 3 avg texture (2..5)
 //        d3d9 : 31 avg math (27..37), 3 avg texture (2..5)
 Pass {
  Name "FORWARD_DELTA"
  Tags { "LIGHTMODE"="ForwardAdd" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend [_SrcBlend] One
  GpuProgramID 413967
Program "vp" {
SubProgram "opengl " {
// Stats: 30 math, 3 textures
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_1, viewDir_4) * tmpvar_1)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_1, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = (((tmpvar_5 * tmpvar_5) * tmpvar_5) * tmpvar_5).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)))
   + 
    ((texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0) * mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic)))
  ) * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (xlv_TEXCOORD5, xlv_TEXCOORD5)
  )).w)) * clamp (dot (tmpvar_1, tmpvar_3), 0.0, 1.0));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 46 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_DetailAlbedoMap_ST]
Vector 16 [_MainTex_ST]
Float 18 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c16, c16.zwzw
mul r0.x, c18.x, c18.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c17.xyxy, c17
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c14
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1.xyz, v1.y, c9
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 oT5.x, c11, r0
dp4 oT5.y, c12, r0
dp4 oT5.z, c13, r0
mad r0.xyz, r0, -c15.w, c15
nrm r1.xyz, r0
mov oT2.w, r1.x
mov oT3.w, r1.y
mov oT4.w, r1.z

"
}
SubProgram "d3d11 " {
// Stats: 50 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedomfdmhjlfpblmamigkefdfapeekglogdabaaaaaakeajaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcpeahaaaaeaaaabaapnabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaa
aaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
hccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
jgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaa
acaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaa
pgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaf
iccabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
agaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 50 math
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedjpkkifndmljamgepccgllinablpbjhhlabaaaaaapeanaaaaaeaaaaaa
daaaaaaahmaeaaaahiamaaaaceanaaaaebgpgodjeeaeaaaaeeaeaaaaaaacpopp
miadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaaaaabaaaaeaaaeaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabia
aaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaia
abaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabbaaoeka
aaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeiaaiaaoekbaeaaaaaeaaaaahia
aaaaoeiaajaappkbajaaoekaceaaaaacacaaahiaaaaaoeiaaiaaaaadaaaaabia
abaaoeiaabaaoeiaahaaaaacaaaaabiaaaaaaaiaafaaaaadabaaahoaaaaaaaia
abaaoeiaafaaaaadaaaaabiaabaaaajabcaaaakaafaaaaadaaaaaciaabaaaaja
bdaaaakaafaaaaadaaaaaeiaabaaaajabeaaaakaafaaaaadabaaabiaabaaffja
bcaaffkaafaaaaadabaaaciaabaaffjabdaaffkaafaaaaadabaaaeiaabaaffja
beaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaabaakkja
bcaakkkaafaaaaadabaaaciaabaakkjabdaakkkaafaaaaadabaaaeiaabaakkja
beaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeia
afaaaaadaaaaahiaaeaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaeaaaaja
aaaaoeiaaeaaaaaeaaaaahiabaaaoekaaeaakkjaaaaaoeiaceaaaaacadaaahia
aaaaoeiaafaaaaadaaaaahiaabaanciaadaamjiaaeaaaaaeaaaaahiaabaamjia
adaanciaaaaaoeibabaaaaacaeaaahoaabaaoeiaabaaaaacacaaahoaadaaoeia
afaaaaadadaaahoaaaaaoeiaaeaappjaafaaaaadaaaaapiaaaaaffjaapaaoeka
aeaaaaaeaaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaad
abaaahiaaaaaffiaafaaoekaaeaaaaaeabaaahiaaeaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiaagaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaahoaahaaoeka
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapia
akaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaioaacaaaaia
abaaaaacadaaaioaacaaffiaabaaaaacaeaaaioaacaakkiappppaaaafdeieefc
peahaaaaeaaaabaapnabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
pcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
diaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaf
iccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheokeaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ijaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaajjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaa
faepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaafeebeoehefeofe
aaklklklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 28 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_1, viewDir_4) * tmpvar_1)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_1, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = (((tmpvar_5 * tmpvar_5) * tmpvar_5) * tmpvar_5).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)))
   + 
    ((texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0) * mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic)))
  ) * _LightColor0.xyz) * clamp (dot (tmpvar_1, tmpvar_3), 0.0, 1.0));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 39 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_DetailAlbedoMap_ST]
Vector 12 [_MainTex_ST]
Float 14 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c12, c12.zwzw
mul r0.x, c14.x, c14.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c13.xyxy, c13
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c10
mad r0.xyz, r0, -c11.w, c11
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r1
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
mov oT2.w, r0.x
mov oT3.w, r0.y
mov oT4.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 39 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedokhadbgfdoiindbdnllglbmjaflljmobabaaaaaaaeaiaaaaadaaaaaa
cmaaaaaaniaaaaaajaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgmagaaaaeaaaabaajlabaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaa
acaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaa
diaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaai
bcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaa
acaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaah
hccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaa
aeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 39 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedlgfnjljfedpohpieaonhogakbahcijidabaaaaaakealaaaaaeaaaaaa
daaaaaaammadaaaaeaakaaaaomakaaaaebgpgodjjeadaaaajeadaaaaaaacpopp
ceadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaaaaaabaaafaaaaaaaaaaadaaaaaaaeaaagaaaaaaaaaaadaaamaaahaaakaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaacaaoejaabaaoekaabaaookaafaaaaad
aaaaabiaadaakkkaadaakkkaanaaaaadaaaaabiaaaaaaaibaaaaaaiaabaaaaac
abaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaiaabaaoeiaadaaoejaaeaaaaae
aaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaadaaaaahiaaaaaffjaalaaoeka
aeaaaaaeaaaaahiaakaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaamaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaahiaanaaoekaaaaappjaaaaaoeiaacaaaaad
abaaahiaaaaaoeiaaeaaoekbaeaaaaaeaaaaahiaaaaaoeiaafaappkbafaaoeka
aiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaad
abaaahoaaaaappiaabaaoeiaafaaaaadabaaabiaabaaaajaaoaaaakaafaaaaad
abaaaciaabaaaajaapaaaakaafaaaaadabaaaeiaabaaaajabaaaaakaafaaaaad
acaaabiaabaaffjaaoaaffkaafaaaaadacaaaciaabaaffjaapaaffkaafaaaaad
acaaaeiaabaaffjabaaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaad
acaaabiaabaakkjaaoaakkkaafaaaaadacaaaciaabaakkjaapaakkkaafaaaaad
acaaaeiaabaakkjabaaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaceaaaaac
acaaahiaabaaoeiaafaaaaadabaaahiaaeaaffjaalaaoekaaeaaaaaeabaaahia
akaaoekaaeaaaajaabaaoeiaaeaaaaaeabaaahiaamaaoekaaeaakkjaabaaoeia
ceaaaaacadaaahiaabaaoeiaafaaaaadabaaahiaacaanciaadaamjiaaeaaaaae
abaaahiaacaamjiaadaanciaabaaoeibabaaaaacaeaaahoaacaaoeiaabaaaaac
acaaahoaadaaoeiaafaaaaadadaaahoaabaaoeiaaeaappjaafaaaaadabaaapia
aaaaffjaahaaoekaaeaaaaaeabaaapiaagaaoekaaaaaaajaabaaoeiaaeaaaaae
abaaapiaaiaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaapiaajaaoekaaaaappja
abaaoeiaaeaaaaaeaaaaadmaabaappiaaaaaoekaabaaoeiaabaaaaacaaaaamma
abaaoeiaabaaaaacacaaaioaaaaaaaiaabaaaaacadaaaioaaaaaffiaabaaaaac
aeaaaioaaaaakkiappppaaaafdeieefcgmagaaaaeaaaabaajlabaaaafjaaaaae
egiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaa
egbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
adaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaa
adaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaa
adaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaa
bkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadoaaaaab
ejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaa
jaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaajaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfcee
aafeebeoehefeofeaaklklklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
// Stats: 36 math, 4 textures
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_1, viewDir_4) * tmpvar_1)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_1, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = (((tmpvar_5 * tmpvar_5) * tmpvar_5) * tmpvar_5).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)))
   + 
    ((texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0) * mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic)))
  ) * (_LightColor0.xyz * 
    ((float((xlv_TEXCOORD5.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz))).w)
  )) * clamp (dot (tmpvar_1, tmpvar_3), 0.0, 1.0));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 47 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 8 [_LightMatrix0]
Matrix 4 [_Object2World]
Matrix 12 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 17 [_MainTex_ST]
Float 19 [_UVSec]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
mul r0.x, c19.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c15
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1.xyz, v1.y, c13
mad r1.xyz, c12, v1.x, r1
mad r1.xyz, c14, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 oT5.x, c8, r0
dp4 oT5.y, c9, r0
dp4 oT5.z, c10, r0
dp4 oT5.w, c11, r0
mad r0.xyz, r0, -c16.w, c16
nrm r1.xyz, r0
mov oT2.w, r1.x
mov oT3.w, r1.y
mov oT4.w, r1.z

"
}
SubProgram "d3d11 " {
// Stats: 50 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedhelcjfcmghlkagmdldphchecmoonanidabaaaaaakeajaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcpeahaaaaeaaaabaapnabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaa
aaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
hccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
jgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaa
acaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaa
pgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaf
iccabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaabcaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
agaaaaaaegiocaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 50 math
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedjbbjpoenfplllmlbdilfemdbmbmpkdapabaaaaaapeanaaaaaeaaaaaa
daaaaaaahmaeaaaahiamaaaaceanaaaaebgpgodjeeaeaaaaeeaeaaaaaaacpopp
miadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaaaaabaaaaeaaaeaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabia
aaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaia
abaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabbaaoeka
aaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeiaaiaaoekbaeaaaaaeaaaaahia
aaaaoeiaajaappkbajaaoekaceaaaaacacaaahiaaaaaoeiaaiaaaaadaaaaabia
abaaoeiaabaaoeiaahaaaaacaaaaabiaaaaaaaiaafaaaaadabaaahoaaaaaaaia
abaaoeiaafaaaaadaaaaabiaabaaaajabcaaaakaafaaaaadaaaaaciaabaaaaja
bdaaaakaafaaaaadaaaaaeiaabaaaajabeaaaakaafaaaaadabaaabiaabaaffja
bcaaffkaafaaaaadabaaaciaabaaffjabdaaffkaafaaaaadabaaaeiaabaaffja
beaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaabaakkja
bcaakkkaafaaaaadabaaaciaabaakkjabdaakkkaafaaaaadabaaaeiaabaakkja
beaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeia
afaaaaadaaaaahiaaeaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaeaaaaja
aaaaoeiaaeaaaaaeaaaaahiabaaaoekaaeaakkjaaaaaoeiaceaaaaacadaaahia
aaaaoeiaafaaaaadaaaaahiaabaanciaadaamjiaaeaaaaaeaaaaahiaabaamjia
adaanciaaaaaoeibabaaaaacaeaaahoaabaaoeiaabaaaaacacaaahoaadaaoeia
afaaaaadadaaahoaaaaaoeiaaeaappjaafaaaaadaaaaapiaaaaaffjaapaaoeka
aeaaaaaeaaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaad
abaaapiaaaaaffiaafaaoekaaeaaaaaeabaaapiaaeaaoekaaaaaaaiaabaaoeia
aeaaaaaeabaaapiaagaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaapoaahaaoeka
aaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapia
akaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaioaacaaaaia
abaaaaacadaaaioaacaaffiaabaaaaacaeaaaioaacaakkiappppaaaafdeieefc
peahaaaaeaaaabaapnabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
pcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
diaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaf
iccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheokeaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ijaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaajjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaa
faepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaafeebeoehefeofe
aaklklklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 31 math, 4 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_1, viewDir_4) * tmpvar_1)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_1, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = (((tmpvar_5 * tmpvar_5) * tmpvar_5) * tmpvar_5).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)))
   + 
    ((texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0) * mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic)))
  ) * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5))).w * textureCube (_LightTexture0, xlv_TEXCOORD5).w)
  )) * clamp (dot (tmpvar_1, tmpvar_3), 0.0, 1.0));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 46 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_DetailAlbedoMap_ST]
Vector 16 [_MainTex_ST]
Float 18 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c16, c16.zwzw
mul r0.x, c18.x, c18.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c17.xyxy, c17
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c14
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1.xyz, v1.y, c9
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 oT5.x, c11, r0
dp4 oT5.y, c12, r0
dp4 oT5.z, c13, r0
mad r0.xyz, r0, -c15.w, c15
nrm r1.xyz, r0
mov oT2.w, r1.x
mov oT3.w, r1.y
mov oT4.w, r1.z

"
}
SubProgram "d3d11 " {
// Stats: 50 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedomfdmhjlfpblmamigkefdfapeekglogdabaaaaaakeajaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcpeahaaaaeaaaabaapnabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaa
aaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
hccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaa
abaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaa
abaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
jgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaa
acaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaa
pgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaf
iccabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
agaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 50 math
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedjpkkifndmljamgepccgllinablpbjhhlabaaaaaapeanaaaaaeaaaaaa
daaaaaaahmaeaaaahiamaaaaceanaaaaebgpgodjeeaeaaaaeeaeaaaaaaacpopp
miadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaaaaabaaaaeaaaeaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabia
aaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaia
abaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabbaaoeka
aaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeiaaiaaoekbaeaaaaaeaaaaahia
aaaaoeiaajaappkbajaaoekaceaaaaacacaaahiaaaaaoeiaaiaaaaadaaaaabia
abaaoeiaabaaoeiaahaaaaacaaaaabiaaaaaaaiaafaaaaadabaaahoaaaaaaaia
abaaoeiaafaaaaadaaaaabiaabaaaajabcaaaakaafaaaaadaaaaaciaabaaaaja
bdaaaakaafaaaaadaaaaaeiaabaaaajabeaaaakaafaaaaadabaaabiaabaaffja
bcaaffkaafaaaaadabaaaciaabaaffjabdaaffkaafaaaaadabaaaeiaabaaffja
beaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaabaakkja
bcaakkkaafaaaaadabaaaciaabaakkjabdaakkkaafaaaaadabaaaeiaabaakkja
beaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeia
afaaaaadaaaaahiaaeaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaeaaaaja
aaaaoeiaaeaaaaaeaaaaahiabaaaoekaaeaakkjaaaaaoeiaceaaaaacadaaahia
aaaaoeiaafaaaaadaaaaahiaabaanciaadaamjiaaeaaaaaeaaaaahiaabaamjia
adaanciaaaaaoeibabaaaaacaeaaahoaabaaoeiaabaaaaacacaaahoaadaaoeia
afaaaaadadaaahoaaaaaoeiaaeaappjaafaaaaadaaaaapiaaaaaffjaapaaoeka
aeaaaaaeaaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaad
abaaahiaaaaaffiaafaaoekaaeaaaaaeabaaahiaaeaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiaagaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaahoaahaaoeka
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapia
akaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaaioaacaaaaia
abaaaaacadaaaioaacaaffiaabaaaaacaeaaaioaacaakkiappppaaaafdeieefc
peahaaaaeaaaabaapnabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
pcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
diaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaf
iccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheokeaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ijaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaajjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaa
faepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaafeebeoehefeofe
aaklklklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 29 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_1, viewDir_4) * tmpvar_1)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_1, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = (((tmpvar_5 * tmpvar_5) * tmpvar_5) * tmpvar_5).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)))
   + 
    ((texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0) * mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic)))
  ) * (_LightColor0.xyz * texture2D (_LightTexture0, xlv_TEXCOORD5).w)) * clamp (dot (tmpvar_1, tmpvar_3), 0.0, 1.0));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 42 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 2
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_DetailAlbedoMap_ST]
Vector 15 [_MainTex_ST]
Float 17 [_UVSec]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c15, c15.zwzw
mul r0.x, c17.x, c17.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c16.xyxy, c16
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c13
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1.xyz, v1.y, c9
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 oT5.x, c11, r0
dp4 oT5.y, c12, r0
mad r0.xyz, r0, -c14.w, c14
mov oT2.w, r0.x
mov oT3.w, r0.y
mov oT4.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 47 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlnhnmcmpanfbgafghbehkoannflladegabaaaaaafiajaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefckiahaaaaeaaaabaaokabaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaaddccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaa
aaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaa
acaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
diaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaf
iccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaabbaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaagaaaaaaegiacaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 47 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedpdcojhdllgbeclihibojlijjamcjpgnoabaaaaaajmanaaaaaeaaaaaa
daaaaaaahaaeaaaacaamaaaammamaaaaebgpgodjdiaeaaaadiaeaaaaaaacpopp
lmadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaaaaabaaaaeaaaeaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabia
aaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaia
abaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabbaaoeka
aaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeiaaiaaoekbaeaaaaaeaaaaahia
aaaaoeiaajaappkbajaaoekaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaac
aaaaaiiaaaaappiaafaaaaadabaaahoaaaaappiaabaaoeiaafaaaaadabaaabia
abaaaajabcaaaakaafaaaaadabaaaciaabaaaajabdaaaakaafaaaaadabaaaeia
abaaaajabeaaaakaafaaaaadacaaabiaabaaffjabcaaffkaafaaaaadacaaacia
abaaffjabdaaffkaafaaaaadacaaaeiaabaaffjabeaaffkaacaaaaadabaaahia
abaaoeiaacaaoeiaafaaaaadacaaabiaabaakkjabcaakkkaafaaaaadacaaacia
abaakkjabdaakkkaafaaaaadacaaaeiaabaakkjabeaakkkaacaaaaadabaaahia
abaaoeiaacaaoeiaceaaaaacacaaahiaabaaoeiaafaaaaadabaaahiaaeaaffja
apaaoekaaeaaaaaeabaaahiaaoaaoekaaeaaaajaabaaoeiaaeaaaaaeabaaahia
baaaoekaaeaakkjaabaaoeiaceaaaaacadaaahiaabaaoeiaafaaaaadabaaahia
acaanciaadaamjiaaeaaaaaeabaaahiaacaamjiaadaanciaabaaoeibabaaaaac
aeaaahoaacaaoeiaabaaaaacacaaahoaadaaoeiaafaaaaadadaaahoaabaaoeia
aeaappjaafaaaaadabaaapiaaaaaffjaapaaoekaaeaaaaaeabaaapiaaoaaoeka
aaaaaajaabaaoeiaaeaaaaaeabaaapiabaaaoekaaaaakkjaabaaoeiaaeaaaaae
abaaapiabbaaoekaaaaappjaabaaoeiaafaaaaadacaaadiaabaaffiaafaaoeka
aeaaaaaeabaaadiaaeaaoekaabaaaaiaacaaoeiaaeaaaaaeabaaadiaagaaoeka
abaakkiaabaaoeiaaeaaaaaeafaaadoaahaaoekaabaappiaabaaoeiaafaaaaad
abaaapiaaaaaffjaalaaoekaaeaaaaaeabaaapiaakaaoekaaaaaaajaabaaoeia
aeaaaaaeabaaapiaamaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaapiaanaaoeka
aaaappjaabaaoeiaaeaaaaaeaaaaadmaabaappiaaaaaoekaabaaoeiaabaaaaac
aaaaammaabaaoeiaabaaaaacacaaaioaaaaaaaiaabaaaaacadaaaioaaaaaffia
abaaaaacaeaaaioaaaaakkiappppaaaafdeieefckiahaaaaeaaaabaaokabaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaa
abaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaa
amaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaa
abaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaa
cgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaa
egacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaa
aeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaa
afaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaa
bbaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaabaaaaaaaagaabaaa
aaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
bcaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaagaaaaaa
egiacaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab
ejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaa
jaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaajaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfcee
aafeebeoehefeofeaaklklklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 40 math, 5 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform mat4 unity_World2Shadow[4];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25);
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * cse_25);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_1, viewDir_4) * tmpvar_1)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_1, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = (((tmpvar_5 * tmpvar_5) * tmpvar_5) * tmpvar_5).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)))
   + 
    ((texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0) * mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic)))
  ) * (_LightColor0.xyz * 
    (((float(
      (xlv_TEXCOORD5.z > 0.0)
    ) * texture2D (_LightTexture0, (
      (xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w)
     + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz))).w) * (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x * (1.0 - _LightShadowData.x))))
  )) * clamp (dot (tmpvar_1, tmpvar_3), 0.0, 1.0));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 51 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 12 [_LightMatrix0]
Matrix 8 [_Object2World]
Matrix 16 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Matrix 0 [unity_World2Shadow0]
Vector 22 [_DetailAlbedoMap_ST]
Vector 21 [_MainTex_ST]
Float 23 [_UVSec]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dp4 oPos.x, c4, v0
dp4 oPos.y, c5, v0
dp4 oPos.z, c6, v0
dp4 oPos.w, c7, v0
mad oT0.xy, v2, c21, c21.zwzw
mul r0.x, c23.x, c23.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c22.xyxy, c22
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, r0, -c19
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1.xyz, v1.y, c17
mad r1.xyz, c16, v1.x, r1
mad r1.xyz, c18, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c8, v4
dp3 r1.y, c9, v4
dp3 r1.z, c10, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r0.w, c11, v0
dp4 oT5.x, c12, r0
dp4 oT5.y, c13, r0
dp4 oT5.z, c14, r0
dp4 oT5.w, c15, r0
dp4 oT6.x, c0, r0
dp4 oT6.y, c1, r0
dp4 oT6.z, c2, r0
dp4 oT6.w, c3, r0
mad r0.xyz, r0, -c20.w, c20
nrm r1.xyz, r0
mov oT2.w, r1.x
mov oT3.w, r1.y
mov oT4.w, r1.z

"
}
SubProgram "d3d11 " {
// Stats: 54 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedfaieimgleenhopjmcglpmjhpblpebifgabaaaaaahaakaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefckiaiaaaaeaaaabaackacaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaaeegiocaaaaeaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaeaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaeaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
diaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaf
iccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 54 math
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0_level_9_1
eefiecedcfbdkggmoonkolklgnbgbcfgpigckhckabaaaaaabiapaaaaaeaaaaaa
daaaaaaaneaeaaaaieanaaaadaaoaaaaebgpgodjjmaeaaaajmaeaaaaaaacpopp
beaeaaaaiiaaaaaaaiaaceaaaaaaieaaaaaaieaaaaaaceaaabaaieaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaaaaabaaaaeaaaeaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaiaaaeaaakaa
aaaaaaaaaeaaaaaaaeaaaoaaaaaaaaaaaeaaamaaahaabcaaaaaaaaaaaaaaaaaa
aaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
aeaaaaaeaaaaadoaacaaoejaabaaoekaabaaookaafaaaaadaaaaabiaadaakkka
adaakkkaanaaaaadaaaaabiaaaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoeja
bcaaaaaeacaaadiaaaaaaaiaabaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeia
acaaeekaacaaoekaafaaaaadaaaaahiaaaaaffjabdaaoekaaeaaaaaeaaaaahia
bcaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabfaaoekaaaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeia
aiaaoekbaeaaaaaeaaaaahiaaaaaoeiaajaappkbajaaoekaceaaaaacacaaahia
aaaaoeiaaiaaaaadaaaaabiaabaaoeiaabaaoeiaahaaaaacaaaaabiaaaaaaaia
afaaaaadabaaahoaaaaaaaiaabaaoeiaafaaaaadaaaaabiaabaaaajabgaaaaka
afaaaaadaaaaaciaabaaaajabhaaaakaafaaaaadaaaaaeiaabaaaajabiaaaaka
afaaaaadabaaabiaabaaffjabgaaffkaafaaaaadabaaaciaabaaffjabhaaffka
afaaaaadabaaaeiaabaaffjabiaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaabaakkjabgaakkkaafaaaaadabaaaciaabaakkjabhaakkka
afaaaaadabaaaeiaabaakkjabiaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaahiaaeaaffjabdaaoekaaeaaaaae
aaaaahiabcaaoekaaeaaaajaaaaaoeiaaeaaaaaeaaaaahiabeaaoekaaeaakkja
aaaaoeiaceaaaaacadaaahiaaaaaoeiaafaaaaadaaaaahiaabaanciaadaamjia
aeaaaaaeaaaaahiaabaamjiaadaanciaaaaaoeibabaaaaacaeaaahoaabaaoeia
abaaaaacacaaahoaadaaoeiaafaaaaadadaaahoaaaaaoeiaaeaappjaafaaaaad
aaaaapiaaaaaffjabdaaoekaaeaaaaaeaaaaapiabcaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiabeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabfaaoeka
aaaappjaaaaaoeiaafaaaaadabaaapiaaaaaffiaafaaoekaaeaaaaaeabaaapia
aeaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaagaaoekaaaaakkiaabaaoeia
aeaaaaaeafaaapoaahaaoekaaaaappiaabaaoeiaafaaaaadabaaapiaaaaaffia
alaaoekaaeaaaaaeabaaapiaakaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapia
amaaoekaaaaakkiaabaaoeiaaeaaaaaeagaaapoaanaaoekaaaaappiaabaaoeia
afaaaaadaaaaapiaaaaaffjaapaaoekaaeaaaaaeaaaaapiaaoaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
bbaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacacaaaioaacaaaaiaabaaaaacadaaaioa
acaaffiaabaaaaacaeaaaioaacaakkiappppaaaafdeieefckiaiaaaaeaaaabaa
ckacaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
amaaaaaafjaaaaaeegiocaaaaeaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaad
pccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaa
abaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaa
amaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aeaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
aeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabcaaaaaadiaaaaaibcaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaaeaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaaaaaaaaabbaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaabaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
adaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaiaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
ahaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaabejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaajaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffied
epepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
neaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 29 math, 3 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_7 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_7.zw;
  vec3 tmpvar_27;
  tmpvar_27 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_27.x;
  tmpvar_4.w = tmpvar_27.y;
  tmpvar_5.w = tmpvar_27.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_1, viewDir_4) * tmpvar_1)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_1, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = (((tmpvar_5 * tmpvar_5) * tmpvar_5) * tmpvar_5).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)))
   + 
    ((texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0) * mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic)))
  ) * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x)) * clamp (dot (tmpvar_1, tmpvar_3), 0.0, 1.0));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 45 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 15 [_DetailAlbedoMap_ST]
Vector 14 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Float 16 [_UVSec]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
"vs_2_0
def c17, 0.5, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
mad oT0.xy, v2, c14, c14.zwzw
mul r0.x, c16.x, c16.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c15.xyxy, c15
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c10
mad r0.xyz, r0, -c13.w, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r1
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r1.y, c1, v0
mul r0.w, r1.y, c11.x
mul r2.w, r0.w, c17.x
dp4 r1.x, c0, v0
dp4 r1.w, c3, v0
mul r2.xz, r1.xyww, c17.x
mad oT5.xy, r2.z, c12.zwzw, r2.xwzw
dp4 r1.z, c2, v0
mov oPos, r1
mov oT5.zw, r1
mov oT2.w, r0.x
mov oT3.w, r0.y
mov oT4.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 42 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednpkhckbdajapnfmpjemaajncoggfheghabaaaaaaleaiaaaaadaaaaaa
cmaaaaaaniaaaaaakiabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcaeahaaaaeaaaabaambabaaaafjaaaaaeegiocaaa
aaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
biaaaaaibcaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaa
dhaaaaajdcaabaaaabaaaaaaagaabaaaabaaaaaaegbabaaaacaaaaaaegbabaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaabaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaamhcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
adaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
aeaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
aeaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
aeaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaadiaaaaaibcaabaaaaeaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaeaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaeaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadiaaaaah
hcaabaaaaeaaaaaajgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaakhcaabaaa
acaaaaaajgaebaaaadaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaadaaaaaadiaaaaahhccabaaaaeaaaaaa
egacbaaaacaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaa
abaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 30 math, 4 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_7 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_7.zw;
  vec3 tmpvar_27;
  tmpvar_27 = (_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w));
  tmpvar_3.w = tmpvar_27.x;
  tmpvar_4.w = tmpvar_27.y;
  tmpvar_5.w = tmpvar_27.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD6 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_1, viewDir_4) * tmpvar_1)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_1, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = (((tmpvar_5 * tmpvar_5) * tmpvar_5) * tmpvar_5).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)))
   + 
    ((texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0) * mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic)))
  ) * (_LightColor0.xyz * 
    (texture2D (_LightTexture0, xlv_TEXCOORD5).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x)
  )) * clamp (dot (tmpvar_1, tmpvar_3), 0.0, 1.0));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 48 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 2
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 17 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Float 19 [_UVSec]
Vector 13 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
"vs_2_0
def c20, 0.5, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
mad oT0.xy, v2, c17, c17.zwzw
mul r0.x, c19.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c13
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1.xyz, v1.y, c9
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 oT5.x, c11, r0
dp4 oT5.y, c12, r0
mad r0.xyz, r0, -c16.w, c16
dp4 r1.y, c1, v0
mul r0.w, r1.y, c14.x
mul r2.w, r0.w, c20.x
dp4 r1.x, c0, v0
dp4 r1.w, c3, v0
mul r2.xz, r1.xyww, c20.x
mad oT6.xy, r2.z, c15.zwzw, r2.xwzw
dp4 r1.z, c2, v0
mov oPos, r1
mov oT6.zw, r1
mov oT2.w, r0.x
mov oT3.w, r0.y
mov oT4.w, r0.z

"
}
SubProgram "d3d11 " {
// Stats: 50 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedjopnmhbekbmbhlbkigejgpacgpahhgniabaaaaaaaiakaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefceaaiaaaaeaaaabaabaacaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaa
agaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaabiaaaaaibcaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaabaaaaaaagaabaaaabaaaaaaegbabaaaacaaaaaa
egbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaabaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaapgipcaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hccabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
adaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaeaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaacaaaaaadiaaaaai
bcaabaaaadaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaaeaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaaeaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaaeaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaadiaaaaaibcaabaaa
aeaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
aeaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
aeaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahhcaabaaaaeaaaaaajgaebaaaacaaaaaacgajbaaaadaaaaaadcaaaaak
hcaabaaaacaaaaaajgaebaaaadaaaaaacgajbaaaacaaaaaaegacbaiaebaaaaaa
aeaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaadaaaaaadiaaaaahhccabaaa
aeaaaaaaegacbaaaacaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaa
bkaabaaaabaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaidcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiacaaaaaaaaaaabbaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaaaaaaaaabaaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaaaaaaaaabcaaaaaakgakbaaaabaaaaaaegaabaaa
abaaaaaadcaaaaakdccabaaaagaaaaaaegiacaaaaaaaaaaabdaaaaaapgapbaaa
abaaaaaaegaabaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
// Stats: 37 math, 4 textures, 1 branches
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25).xyz;
  xlv_TEXCOORD6 = (cse_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  tmpvar_3 = (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  float tmpvar_7;
  tmpvar_7 = ((sqrt(
    dot (xlv_TEXCOORD6, xlv_TEXCOORD6)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_8;
  tmpvar_8 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  float tmpvar_9;
  if ((tmpvar_8.x < tmpvar_7)) {
    tmpvar_9 = _LightShadowData.x;
  } else {
    tmpvar_9 = 1.0;
  };
  vec3 viewDir_10;
  viewDir_10 = -(xlv_TEXCOORD1);
  vec2 tmpvar_11;
  tmpvar_11.x = dot ((viewDir_10 - (2.0 * 
    (dot (tmpvar_1, viewDir_10) * tmpvar_1)
  )), tmpvar_5);
  tmpvar_11.y = (1.0 - clamp (dot (tmpvar_1, viewDir_10), 0.0, 1.0));
  vec2 tmpvar_12;
  tmpvar_12.x = (((tmpvar_11 * tmpvar_11) * tmpvar_11) * tmpvar_11).x;
  tmpvar_12.y = (1.0 - _Glossiness);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (((tmpvar_3 + 
    ((texture2D (unity_NHxRoughness, tmpvar_12).w * 16.0) * tmpvar_4)
  ) * (_LightColor0.xyz * 
    (tmpvar_6.w * tmpvar_9)
  )) * clamp (dot (tmpvar_1, tmpvar_5), 0.0, 1.0));
  vec4 xlat_varoutput_14;
  xlat_varoutput_14.xyz = tmpvar_13.xyz;
  xlat_varoutput_14.w = 1.0;
  gl_FragData[0] = xlat_varoutput_14;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 47 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 16 [_LightPositionRange]
Vector 17 [_MainTex_ST]
Float 19 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
mul r0.x, c19.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c14
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1.xyz, v1.y, c9
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 oT5.x, c11, r0
dp4 oT5.y, c12, r0
dp4 oT5.z, c13, r0
add oT6.xyz, r0, -c16
mad r0.xyz, r0, -c15.w, c15
nrm r1.xyz, r0
mov oT2.w, r1.x
mov oT3.w, r1.y
mov oT4.w, r1.z

"
}
SubProgram "d3d11 " {
// Stats: 51 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedmdfjgokbghkeokclfjbfkffdkagoljgkabaaaaaaomajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcceaiaaaaeaaaabaaajacaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaa
agaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaamhcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 51 math
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedlhlfgclomhlpnloojgmmdmljepcgedpnabaaaaaaemaoaaaaaeaaaaaa
daaaaaaaimaeaaaaliamaaaageanaaaaebgpgodjfeaeaaaafeaeaaaaaaacpopp
niadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaaaaabaaaaeaaaeaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaacaaajaaaaaaaaaaadaaaaaaaeaaalaa
aaaaaaaaadaaamaaahaaapaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabia
aaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaia
abaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaad
aaaaahiaaaaaffjabaaaoekaaeaaaaaeaaaaahiaapaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabbaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabcaaoeka
aaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeiaaiaaoekbaiaaaaadaaaaaiia
abaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoaaaaappia
abaaoeiaafaaaaadabaaabiaabaaaajabdaaaakaafaaaaadabaaaciaabaaaaja
beaaaakaafaaaaadabaaaeiaabaaaajabfaaaakaafaaaaadacaaabiaabaaffja
bdaaffkaafaaaaadacaaaciaabaaffjabeaaffkaafaaaaadacaaaeiaabaaffja
bfaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaadacaaabiaabaakkja
bdaakkkaafaaaaadacaaaciaabaakkjabeaakkkaafaaaaadacaaaeiaabaakkja
bfaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaceaaaaacacaaahiaabaaoeia
afaaaaadabaaahiaaeaaffjabaaaoekaaeaaaaaeabaaahiaapaaoekaaeaaaaja
abaaoeiaaeaaaaaeabaaahiabbaaoekaaeaakkjaabaaoeiaceaaaaacadaaahia
abaaoeiaafaaaaadabaaahiaacaanciaadaamjiaaeaaaaaeabaaahiaacaamjia
adaanciaabaaoeibabaaaaacaeaaahoaacaaoeiaabaaaaacacaaahoaadaaoeia
afaaaaadadaaahoaabaaoeiaaeaappjaafaaaaadabaaapiaaaaaffjabaaaoeka
aeaaaaaeabaaapiaapaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaapiabbaaoeka
aaaakkjaabaaoeiaaeaaaaaeabaaapiabcaaoekaaaaappjaabaaoeiaafaaaaad
acaaahiaabaaffiaafaaoekaaeaaaaaeacaaahiaaeaaoekaabaaaaiaacaaoeia
aeaaaaaeabaaahiaagaaoekaabaakkiaacaaoeiaaeaaaaaeafaaahoaahaaoeka
abaappiaabaaoeiaacaaaaadagaaahoaaaaaoeiaakaaoekbaeaaaaaeaaaaahia
aaaaoeiaajaappkbajaaoekaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaapia
aaaaffjaamaaoekaaeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaanaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaaioaabaaaaiaabaaaaacadaaaioaabaaffiaabaaaaac
aeaaaioaabaakkiappppaaaafdeieefcceaiaaaaeaaaabaaajacaaaafjaaaaae
egiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaai
bcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaaj
dcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaa
dcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
diaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaf
iccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheokeaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ijaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaajjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaa
faepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaafeebeoehefeofe
aaklklklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
// Stats: 38 math, 5 textures, 1 branches
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * gl_Vertex);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * TANGENT.www);
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_3.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_4.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_5.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_6.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_3.w = tmpvar_24.x;
  tmpvar_4.w = tmpvar_24.y;
  tmpvar_5.w = tmpvar_24.z;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_6.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD2_1 = tmpvar_4;
  xlv_TEXCOORD2_2 = tmpvar_5;
  vec4 cse_25;
  cse_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * cse_25).xyz;
  xlv_TEXCOORD6 = (cse_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  tmpvar_3 = (tmpvar_2 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  vec4 tmpvar_7;
  tmpvar_7 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  float tmpvar_8;
  tmpvar_8 = ((sqrt(
    dot (xlv_TEXCOORD6, xlv_TEXCOORD6)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  float tmpvar_10;
  if ((tmpvar_9.x < tmpvar_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  vec3 viewDir_11;
  viewDir_11 = -(xlv_TEXCOORD1);
  vec2 tmpvar_12;
  tmpvar_12.x = dot ((viewDir_11 - (2.0 * 
    (dot (tmpvar_1, viewDir_11) * tmpvar_1)
  )), tmpvar_5);
  tmpvar_12.y = (1.0 - clamp (dot (tmpvar_1, viewDir_11), 0.0, 1.0));
  vec2 tmpvar_13;
  tmpvar_13.x = (((tmpvar_12 * tmpvar_12) * tmpvar_12) * tmpvar_12).x;
  tmpvar_13.y = (1.0 - _Glossiness);
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((tmpvar_3 + 
    ((texture2D (unity_NHxRoughness, tmpvar_13).w * 16.0) * tmpvar_4)
  ) * (_LightColor0.xyz * 
    ((tmpvar_6.w * tmpvar_7.w) * tmpvar_10)
  )) * clamp (dot (tmpvar_1, tmpvar_5), 0.0, 1.0));
  vec4 xlat_varoutput_15;
  xlat_varoutput_15.xyz = tmpvar_14.xyz;
  xlat_varoutput_15.w = 1.0;
  gl_FragData[0] = xlat_varoutput_15;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 47 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
Matrix 11 [_LightMatrix0] 3
Matrix 4 [_Object2World]
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 18 [_DetailAlbedoMap_ST]
Vector 16 [_LightPositionRange]
Vector 17 [_MainTex_ST]
Float 19 [_UVSec]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_texcoord1 v3
dcl_tangent v4
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
mul r0.x, c19.x, c19.x
sge r0.x, -r0.x, r0.x
mov r1.xy, v2
lrp r2.xy, r0.x, r1, v3
mad oT0.zw, r2.xyxy, c18.xyxy, c18
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, r0, -c14
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul oT1.xyz, r1.w, r1
mul r1.xyz, v1.y, c9
mad r1.xyz, c8, v1.x, r1
mad r1.xyz, c10, v1.z, r1
nrm r2.xyz, r1
dp3 r1.x, c4, v4
dp3 r1.y, c5, v4
dp3 r1.z, c6, v4
nrm r3.xyz, r1
mul r1.xyz, r2.zxyw, r3.yzxw
mad r1.xyz, r2.yzxw, r3.zxyw, -r1
mov oT4.xyz, r2
mov oT2.xyz, r3
mul oT3.xyz, r1, v4.w
dp4 r0.w, c7, v0
dp4 oT5.x, c11, r0
dp4 oT5.y, c12, r0
dp4 oT5.z, c13, r0
add oT6.xyz, r0, -c16
mad r0.xyz, r0, -c15.w, c15
nrm r1.xyz, r0
mov oT2.w, r1.x
mov oT3.w, r1.y
mov oT4.w, r1.z

"
}
SubProgram "d3d11 " {
// Stats: 51 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedmdfjgokbghkeokclfjbfkffdkagoljgkabaaaaaaomajaaaaadaaaaaa
cmaaaaaaniaaaaaamaabaaaaejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcceaiaaaaeaaaabaaajacaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaa
agaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaamhcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaa
ckbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
dgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 51 math
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedlhlfgclomhlpnloojgmmdmljepcgedpnabaaaaaaemaoaaaaaeaaaaaa
daaaaaaaimaeaaaaliamaaaageanaaaaebgpgodjfeaeaaaafeaeaaaaaaacpopp
niadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaaaaabaaaaeaaaeaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaacaaajaaaaaaaaaaadaaaaaaaeaaalaa
aaaaaaaaadaaamaaahaaapaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabia
aaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaia
abaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaad
aaaaahiaaaaaffjabaaaoekaaeaaaaaeaaaaahiaapaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabbaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabcaaoeka
aaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeiaaiaaoekbaiaaaaadaaaaaiia
abaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoaaaaappia
abaaoeiaafaaaaadabaaabiaabaaaajabdaaaakaafaaaaadabaaaciaabaaaaja
beaaaakaafaaaaadabaaaeiaabaaaajabfaaaakaafaaaaadacaaabiaabaaffja
bdaaffkaafaaaaadacaaaciaabaaffjabeaaffkaafaaaaadacaaaeiaabaaffja
bfaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaadacaaabiaabaakkja
bdaakkkaafaaaaadacaaaciaabaakkjabeaakkkaafaaaaadacaaaeiaabaakkja
bfaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaceaaaaacacaaahiaabaaoeia
afaaaaadabaaahiaaeaaffjabaaaoekaaeaaaaaeabaaahiaapaaoekaaeaaaaja
abaaoeiaaeaaaaaeabaaahiabbaaoekaaeaakkjaabaaoeiaceaaaaacadaaahia
abaaoeiaafaaaaadabaaahiaacaanciaadaamjiaaeaaaaaeabaaahiaacaamjia
adaanciaabaaoeibabaaaaacaeaaahoaacaaoeiaabaaaaacacaaahoaadaaoeia
afaaaaadadaaahoaabaaoeiaaeaappjaafaaaaadabaaapiaaaaaffjabaaaoeka
aeaaaaaeabaaapiaapaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaapiabbaaoeka
aaaakkjaabaaoeiaaeaaaaaeabaaapiabcaaoekaaaaappjaabaaoeiaafaaaaad
acaaahiaabaaffiaafaaoekaaeaaaaaeacaaahiaaeaaoekaabaaaaiaacaaoeia
aeaaaaaeabaaahiaagaaoekaabaakkiaacaaoeiaaeaaaaaeafaaahoaahaaoeka
abaappiaabaaoeiaacaaaaadagaaahoaaaaaoeiaakaaoekbaeaaaaaeaaaaahia
aaaaoeiaajaappkbajaaoekaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaapia
aaaaffjaamaaoekaaeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaanaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaaioaabaaaaiaabaaaaacadaaaioaabaaffiaabaaaaac
aeaaaioaabaakkiappppaaaafdeieefcceaiaaaaeaaaabaaajacaaaafjaaaaae
egiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabiaaaaai
bcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaaaaadhaaaaaj
dcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaaegbabaaaadaaaaaa
dcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaaaaaaaajhccabaaaahaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaeaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaibcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
diaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaf
iccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheokeaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ijaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaajjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaa
faepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaafeebeoehefeofe
aaklklklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "d3d11_9x " {
// Stats: 47 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0_level_9_1
eefiecednadoancdkklidnkgoipnkdojeokbmbheabaaaaaakmanaaaaaeaaaaaa
daaaaaaahaaeaaaadaamaaaanmamaaaaebgpgodjdiaeaaaadiaeaaaaaaacpopp
lmadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaaaaaabaaafaaaaaaaaaaadaaaiaaaeaaagaaaaaaaaaaaeaaaaaaaeaaakaa
aaaaaaaaaeaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaacaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaadaakkkaadaakkkaanaaaaadaaaaabia
aaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoejabcaaaaaeacaaadiaaaaaaaia
abaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeiaacaaeekaacaaoekaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabbaaoeka
aaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeiaaeaaoekbaeaaaaaeaaaaahia
aaaaoeiaafaappkbafaaoekaaiaaaaadaaaaaiiaabaaoeiaabaaoeiaahaaaaac
aaaaaiiaaaaappiaafaaaaadabaaahoaaaaappiaabaaoeiaafaaaaadabaaabia
abaaaajabcaaaakaafaaaaadabaaaciaabaaaajabdaaaakaafaaaaadabaaaeia
abaaaajabeaaaakaafaaaaadacaaabiaabaaffjabcaaffkaafaaaaadacaaacia
abaaffjabdaaffkaafaaaaadacaaaeiaabaaffjabeaaffkaacaaaaadabaaahia
abaaoeiaacaaoeiaafaaaaadacaaabiaabaakkjabcaakkkaafaaaaadacaaacia
abaakkjabdaakkkaafaaaaadacaaaeiaabaakkjabeaakkkaacaaaaadabaaahia
abaaoeiaacaaoeiaceaaaaacacaaahiaabaaoeiaafaaaaadabaaahiaaeaaffja
apaaoekaaeaaaaaeabaaahiaaoaaoekaaeaaaajaabaaoeiaaeaaaaaeabaaahia
baaaoekaaeaakkjaabaaoeiaceaaaaacadaaahiaabaaoeiaafaaaaadabaaahia
acaanciaadaamjiaaeaaaaaeabaaahiaacaamjiaadaanciaabaaoeibabaaaaac
aeaaahoaacaaoeiaabaaaaacacaaahoaadaaoeiaafaaaaadadaaahoaabaaoeia
aeaappjaafaaaaadabaaapiaaaaaffjaapaaoekaaeaaaaaeabaaapiaaoaaoeka
aaaaaajaabaaoeiaaeaaaaaeabaaapiabaaaoekaaaaakkjaabaaoeiaaeaaaaae
abaaapiabbaaoekaaaaappjaabaaoeiaafaaaaadacaaapiaabaaffiaahaaoeka
aeaaaaaeacaaapiaagaaoekaabaaaaiaacaaoeiaaeaaaaaeacaaapiaaiaaoeka
abaakkiaacaaoeiaaeaaaaaeafaaapoaajaaoekaabaappiaacaaoeiaafaaaaad
abaaapiaaaaaffjaalaaoekaaeaaaaaeabaaapiaakaaoekaaaaaaajaabaaoeia
aeaaaaaeabaaapiaamaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaapiaanaaoeka
aaaappjaabaaoeiaaeaaaaaeaaaaadmaabaappiaaaaaoekaabaaoeiaabaaaaac
aaaaammaabaaoeiaabaaaaacacaaaioaaaaaaaiaabaaaaacadaaaioaaaaaffia
abaaaaacaeaaaioaaaaakkiappppaaaafdeieefcliahaaaaeaaaabaaooabaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadpccabaaa
agaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaaacaaaaaa
egbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaeaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
adaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaeaaaaaa
egiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaeaaaaaa
amaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaeaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabcaaaaaadiaaaaai
bcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabcaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaa
adaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabaaaaaaadiaaaaaiccaabaaa
adaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabbaaaaaadiaaaaaiecaabaaa
adaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabcaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaiaebaaaaaa
adaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaaaeaaaaaa
bkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheokeaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
jjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeo
aaeoepfcenebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "d3d11_9x " {
// Stats: 51 math
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 320
Matrix 256 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_DetailAlbedoMap_ST]
Float 232 [_UVSec]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0_level_9_1
eefiecedjekglohepbhmbengldknohlljdmfpcofabaaaaaamaaoaaaaaeaaaaaa
daaaaaaamiaeaaaacmanaaaanianaaaaebgpgodjjaaeaaaajaaeaaaaaaacpopp
aiaeaaaaiiaaaaaaaiaaceaaaaaaieaaaaaaieaaaaaaceaaabaaieaaaaaaalaa
acaaabaaaaaaaaaaaaaaaoaaabaaadaaaaaaaaaaaaaabaaaaeaaaeaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaiaaaeaaakaa
aaaaaaaaaeaaaaaaaeaaaoaaaaaaaaaaaeaaamaaahaabcaaaaaaaaaaaaaaaaaa
aaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
aeaaaaaeaaaaadoaacaaoejaabaaoekaabaaookaafaaaaadaaaaabiaadaakkka
adaakkkaanaaaaadaaaaabiaaaaaaaibaaaaaaiaabaaaaacabaaadiaacaaoeja
bcaaaaaeacaaadiaaaaaaaiaabaaoeiaadaaoejaaeaaaaaeaaaaamoaacaaeeia
acaaeekaacaaoekaafaaaaadaaaaahiaaaaaffjabdaaoekaaeaaaaaeaaaaahia
bcaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabfaaoekaaaaappjaaaaaoeiaacaaaaadabaaahiaaaaaoeia
aiaaoekbaeaaaaaeaaaaahiaaaaaoeiaajaappkbajaaoekaaiaaaaadaaaaaiia
abaaoeiaabaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoaaaaappia
abaaoeiaafaaaaadabaaabiaabaaaajabgaaaakaafaaaaadabaaaciaabaaaaja
bhaaaakaafaaaaadabaaaeiaabaaaajabiaaaakaafaaaaadacaaabiaabaaffja
bgaaffkaafaaaaadacaaaciaabaaffjabhaaffkaafaaaaadacaaaeiaabaaffja
biaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaadacaaabiaabaakkja
bgaakkkaafaaaaadacaaaciaabaakkjabhaakkkaafaaaaadacaaaeiaabaakkja
biaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaceaaaaacacaaahiaabaaoeia
afaaaaadabaaahiaaeaaffjabdaaoekaaeaaaaaeabaaahiabcaaoekaaeaaaaja
abaaoeiaaeaaaaaeabaaahiabeaaoekaaeaakkjaabaaoeiaceaaaaacadaaahia
abaaoeiaafaaaaadabaaahiaacaanciaadaamjiaaeaaaaaeabaaahiaacaamjia
adaanciaabaaoeibabaaaaacaeaaahoaacaaoeiaabaaaaacacaaahoaadaaoeia
afaaaaadadaaahoaabaaoeiaaeaappjaafaaaaadabaaapiaaaaaffjabdaaoeka
aeaaaaaeabaaapiabcaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaapiabeaaoeka
aaaakkjaabaaoeiaaeaaaaaeabaaapiabfaaoekaaaaappjaabaaoeiaafaaaaad
acaaadiaabaaffiaafaaoekaaeaaaaaeacaaadiaaeaaoekaabaaaaiaacaaoeia
aeaaaaaeacaaadiaagaaoekaabaakkiaacaaoeiaaeaaaaaeafaaadoaahaaoeka
abaappiaacaaoeiaafaaaaadacaaapiaabaaffiaalaaoekaaeaaaaaeacaaapia
akaaoekaabaaaaiaacaaoeiaaeaaaaaeacaaapiaamaaoekaabaakkiaacaaoeia
aeaaaaaeagaaapoaanaaoekaabaappiaacaaoeiaafaaaaadabaaapiaaaaaffja
apaaoekaaeaaaaaeabaaapiaaoaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaapia
baaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaapiabbaaoekaaaaappjaabaaoeia
aeaaaaaeaaaaadmaabaappiaaaaaoekaabaaoeiaabaaaaacaaaaammaabaaoeia
abaaaaacacaaaioaaaaaaaiaabaaaaacadaaaioaaaaaffiaabaaaaacaeaaaioa
aaaakkiappppaaaafdeieefcfmaiaaaaeaaaabaabhacaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaaeegiocaaa
aeaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadpcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaad
pccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaabiaaaaaibcaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbabaaa
acaaaaaaegbabaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagaebaaaaaaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaeaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaeaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgipcaaaacaaaaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aeaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaamaaaaaaagbabaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabaaaaaaa
diaaaaaiccaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabbaaaaaa
diaaaaaiecaabaaaacaaaaaaakbabaaaabaaaaaaakiacaaaaeaaaaaabcaaaaaa
diaaaaaibcaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabaaaaaaa
diaaaaaiccaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabbaaaaaa
diaaaaaiecaabaaaadaaaaaabkbabaaaabaaaaaabkiacaaaaeaaaaaabcaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaai
bcaabaaaadaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabaaaaaaadiaaaaai
ccaabaaaadaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabbaaaaaadiaaaaai
ecaabaaaadaaaaaackbabaaaabaaaaaackiacaaaaeaaaaaabcaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaa
acaaaaaadiaaaaahhcaabaaaadaaaaaajgaebaaaabaaaaaacgajbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgaebaaaacaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaadiaaaaah
hccabaaaaeaaaaaaegacbaaaabaaaaaapgbpbaaaaeaaaaaadgaaaaaficcabaaa
aeaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaaafaaaaaackaabaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaabbaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaa
egaabaaaabaaaaaadcaaaaakdccabaaaagaaaaaaegiacaaaaaaaaaaabdaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaahaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaabejfdeheokeaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaafeebeoehefeofeaaklklklepfdeheooaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
neaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
neaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 30 math, 3 textures
Keywords { "POINT" "SHADOWS_OFF" }
Vector 2 [_Color]
Float 4 [_Glossiness]
Vector 1 [_LightColor0]
Float 3 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
def c5, 1, 16, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dp3_pp r0.w, t5, t5
mov_pp r0.xy, r0.w
nrm_pp r1.xyz, t4
dp3_pp r1.w, -t1, r1
add_pp r1.w, r1.w, r1.w
mad_pp r2.xyz, r1, -r1.w, -t1
mov_pp r3.x, t2.w
mov_pp r3.y, t3.w
mov_pp r3.z, t4.w
dp3_pp r1.w, r2, r3
mul_pp r1.w, r1.w, r1.w
mul_pp r2.x, r1.w, r1.w
mov r1.w, c5.x
add_pp r2.y, r1.w, -c4.x
texld_pp r0, r0, s2
texld r2, r2, s0
texld r4, t0, s1
mul_pp r0.xyz, r0.x, c1
dp3_sat_pp r0.w, r1, r3
mul_pp r4.w, r2.x, c5.y
mov r1, c0
mad_pp r2.xyz, c2, r4, -r1
mul_pp r3.xyz, r4, c2
mad_pp r1.xyz, c3.x, r2, r1
mul_pp r1.xyz, r1, r4.w
mad_pp r1.w, c3.x, -r1.w, r1.w
mad_pp r1.xyz, r3, r1.w, r1
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0.w, r0
mov_pp r0.w, c5.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 22 math, 3 textures
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhlbnaaibdkhlphhnfiofdncaglfcaaababaaaaaaiiafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaaeaaaaeaaaaaaabeabaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaia
ebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaacaaaaaa
dkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaaf
ecaabaaaacaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaajccaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiaebefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaa
acaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaa
dcaaaaanicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
agajbaaaabaaaaaapgapbaaaabaaaaaafgaobaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaa
agaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaa
abaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 22 math, 3 textures
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedaedmfmjfipnnajamdoemdbopihafngplabaaaaaagaaiaaaaaeaaaaaa
daaaaaaaaeadaaaafmahaaaacmaiaaaaebgpgodjmmacaaaammacaaaaaaacpppp
gmacaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaacaaaaaa
aaababaaabacacaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaa
aaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaaaaacppppfbaaaaaf
aeaaapkaaaaaiadpaaaaiaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaia
adaacplabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaaiaafaachlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
aiaaaaadaaaaciiaafaaoelaafaaoelaabaaaaacaaaacdiaaaaappiaceaaaaac
abaachiaaeaaoelaaiaaaaadabaaciiaabaaoelbabaaoeiaacaaaaadabaaciia
abaappiaabaappiaaeaaaaaeacaachiaabaaoeiaabaappibabaaoelbabaaaaac
adaacbiaacaapplaabaaaaacadaacciaadaapplaabaaaaacadaaceiaaeaappla
aiaaaaadabaaciiaacaaoeiaadaaoeiaafaaaaadabaaciiaabaappiaabaappia
afaaaaadacaacbiaabaappiaabaappiaabaaaaacaaaaamiaadaaoekaacaaaaad
acaacciaaaaappibaeaaaakaecaaaaadaeaacpiaaaaaoeiaacaioekaecaaaaad
acaaapiaacaaoeiaaaaioekaecaaaaadafaaapiaaaaaoelaabaioekaafaaaaad
acaacoiaaeaaaaiaabaablkaaiaaaaadafaadiiaabaaoeiaadaaoeiaafaaaaad
aaaacbiaacaaaaiaaeaaffkaabaaaaacabaaahiaaaaaoekaaeaaaaaeabaachia
acaaoekaafaaoeiaabaaoeibafaaaaadadaachiaafaaoeiaacaaoekaaeaaaaae
abaachiaaaaakkiaabaaoeiaaaaaoekaafaaaaadabaachiaaaaaaaiaabaaoeia
aeaaaaaeabaaciiaaaaakkiaaaaappkbaaaappkaaeaaaaaeaaaachiaadaaoeia
abaappiaabaaoeiaafaaaaadaaaachiaacaabliaaaaaoeiaafaaaaadaaaachia
afaappiaaaaaoeiaabaaaaacaaaaciiaaeaaaakaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcfaaeaaaaeaaaaaaabeabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaad
icbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaia
ebaaaaaaacaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaaf
ccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
bacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaajccaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
hcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaaacaaaaaakgikcaaaaaaaaaaa
anaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaadcaaaaanicaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaa
aaaaaaaaacaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaapgapbaaa
abaaaaaafgaobaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agajbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 27 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 2 [_Color]
Float 4 [_Glossiness]
Vector 1 [_LightColor0]
Float 3 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c5, 1, 16, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_2d s0
dcl_2d s1
nrm_pp r0.xyz, t4
dp3_pp r0.w, -t1, r0
add_pp r0.w, r0.w, r0.w
mad_pp r1.xyz, r0, -r0.w, -t1
mov_pp r2.x, t2.w
mov_pp r2.y, t3.w
mov_pp r2.z, t4.w
dp3_pp r0.w, r1, r2
dp3_sat_pp r0.x, r0, r2
mul_pp r0.y, r0.w, r0.w
mul_pp r1.x, r0.y, r0.y
mov r2.x, c5.x
add_pp r1.y, r2.x, -c4.x
texld r1, r1, s0
texld r2, t0, s1
mul_pp r2.w, r1.x, c5.y
mov r1, c0
mad_pp r0.yzw, c2.wzyx, r2.wzyx, -r1.wzyx
mul_pp r2.xyz, r2, c2
mad_pp r0.yzw, c3.x, r0, r1.wzyx
mul_pp r0.yzw, r0, r2.w
mad_pp r2.w, c3.x, -r1.w, r1.w
mad_pp r0.yzw, r2.wzyx, r2.w, r0
mul_pp r0.yzw, r0, c1.wzyx
mul_pp r0.xyz, r0.x, r0.wzyx
mov_pp r0.w, c5.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 20 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpbaoogaphfijijephgppkjeipmcjfgeaabaaaaaaomaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmadaaaa
eaaaaaaapdaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaa
gcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaia
ebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaacaaaaaa
dkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaaf
ecaabaaaacaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaajccaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiaebefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaa
acaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaa
dcaaaaanicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
agajbaaaabaaaaaapgapbaaaabaaaaaafgaobaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaadiaaaaahhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 20 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddfbllgfcaohbnlkngcmcihangolffgnnabaaaaaagmahaaaaaeaaaaaa
daaaaaaakmacaaaaiaagaaaadiahaaaaebgpgodjheacaaaaheacaaaaaaacpppp
biacaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaabaaaaaa
aaababaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaaaaaaajaa
abaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapka
aaaaiadpaaaaiaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaiaadaacpla
bpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkaceaaaaacaaaachiaaeaaoelaaiaaaaadaaaaciiaabaaoelbaaaaoeia
acaaaaadaaaaciiaaaaappiaaaaappiaaeaaaaaeabaachiaaaaaoeiaaaaappib
abaaoelbabaaaaacacaacbiaacaapplaabaaaaacacaacciaadaapplaabaaaaac
acaaceiaaeaapplaaiaaaaadaaaaciiaabaaoeiaacaaoeiaaiaaaaadaaaadbia
aaaaoeiaacaaoeiaafaaaaadaaaacciaaaaappiaaaaappiaafaaaaadabaacbia
aaaaffiaaaaaffiaabaaaaacaaaaamiaadaaoekaacaaaaadabaacciaaaaappib
aeaaaakaecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaadacaaapiaaaaaoela
abaioekaafaaaaadacaaciiaabaaaaiaaeaaffkaabaaaaacabaaahiaaaaaoeka
aeaaaaaeabaachiaacaaoekaacaaoeiaabaaoeibafaaaaadacaachiaacaaoeia
acaaoekaaeaaaaaeabaachiaaaaakkiaabaaoeiaaaaaoekaafaaaaadabaachia
abaaoeiaacaappiaaeaaaaaeabaaciiaaaaakkiaaaaappkbaaaappkaaeaaaaae
aaaacoiaacaabliaabaappiaabaabliaafaaaaadaaaacoiaaaaaoeiaabaablka
afaaaaadaaaachiaaaaaaaiaaaaabliaabaaaaacaaaaciiaaeaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcmmadaaaaeaaaaaaapdaaaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaia
ebaaaaaaacaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaaf
ccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
bacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaajccaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
hcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaaabaaaaaaegiccaia
ebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaaacaaaaaakgikcaaaaaaaaaaa
anaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaadcaaaaanicaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaa
aaaaaaaaacaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaapgapbaaa
abaaaaaafgaobaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agijcaaaaaaaaaaaagaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
ejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 34 math, 4 textures
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 2 [_Color]
Float 4 [_Glossiness]
Vector 1 [_LightColor0]
Float 3 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_2_0
def c5, 0.5, 0, 1, 16
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
rcp r0.w, t5.w
mad_pp r0.xy, t5, r0.w, c5.x
dp3_pp r1.w, t5, t5
mov_pp r1.xy, r1.w
nrm_pp r2.xyz, t4
dp3_pp r2.w, -t1, r2
add_pp r2.w, r2.w, r2.w
mad_pp r3.xyz, r2, -r2.w, -t1
mov_pp r4.x, t2.w
mov_pp r4.y, t3.w
mov_pp r4.z, t4.w
dp3_pp r2.w, r3, r4
mul_pp r2.w, r2.w, r2.w
mul_pp r3.x, r2.w, r2.w
mov r2.w, c5.z
add_pp r3.y, r2.w, -c4.x
texld_pp r0, r0, s2
texld_pp r1, r1, s3
texld r3, r3, s0
texld r5, t0, s1
mul r2.w, r0.w, r1.x
mul_pp r0.xyz, r2.w, c1
cmp_pp r0.xyz, -t5.z, c5.y, r0
dp3_sat_pp r0.w, r2, r4
mul_pp r5.w, r3.x, c5.w
mov r1, c0
mad_pp r2.xyz, c2, r5, -r1
mul_pp r3.xyz, r5, c2
mad_pp r1.xyz, c3.x, r2, r1
mul_pp r1.xyz, r1, r5.w
mad_pp r1.w, c3.x, -r1.w, r1.w
mad_pp r1.xyz, r3, r1.w, r1
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0.w, r0
mov r0.w, c5.z
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 28 math, 4 textures
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [_LightTextureB0] 2D 3
SetTexture 3 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbobdhhddbmgeoomlnegeodaoodabccllabaaaaaahmagaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeafaaaaeaaaaaaafbabaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
adaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaad
pcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaa
abaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaia
ebaaaaaaacaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaaf
ccaabaaaadaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
bacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
ocaabaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaia
ebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaa
anaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaa
abaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaa
aaaaaaaaacaaaaaadcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaa
aaaaaaaafgaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
jgahbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 28 math, 4 textures
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [_LightTextureB0] 2D 3
SetTexture 3 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbehodkfanopdejdgpgefgahgddphjggoabaaaaaaliajaaaaaeaaaaaa
daaaaaaagiadaaaaleaiaaaaieajaaaaebgpgodjdaadaaaadaadaaaaaaacpppp
mmacaaaageaaaaaaaeaadeaaaaaageaaaaaageaaaeaaceaaaaaageaaadaaaaaa
aaababaaabacacaaacadadaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaaabaaabaa
aaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaaaaacpppp
fbaaaaafaeaaapkaaaaaaadpaaaaaaaaaaaaiadpaaaaiaebbpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaacplabpaaaaac
aaaaaaiaadaacplabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaaiaafaacpla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkaagaaaaacaaaaaiiaafaapplaaeaaaaae
aaaacdiaafaaoelaaaaappiaaeaaaakaaiaaaaadabaaciiaafaaoelaafaaoela
abaaaaacabaacdiaabaappiaceaaaaacacaachiaaeaaoelaaiaaaaadacaaciia
abaaoelbacaaoeiaacaaaaadacaaciiaacaappiaacaappiaaeaaaaaeadaachia
acaaoeiaacaappibabaaoelbabaaaaacaeaacbiaacaapplaabaaaaacaeaaccia
adaapplaabaaaaacaeaaceiaaeaapplaaiaaaaadacaaciiaadaaoeiaaeaaoeia
afaaaaadacaaciiaacaappiaacaappiaafaaaaadadaacbiaacaappiaacaappia
abaaaaacacaaaiiaaeaakkkaacaaaaadadaacciaacaappiaadaappkbecaaaaad
aaaacpiaaaaaoeiaacaioekaecaaaaadabaacpiaabaaoeiaadaioekaecaaaaad
adaaapiaadaaoeiaaaaioekaecaaaaadafaaapiaaaaaoelaabaioekaafaaaaad
acaaaiiaaaaappiaabaaaaiaafaaaaadaaaachiaacaappiaabaaoekafiaaaaae
aaaachiaafaakklbaeaaffkaaaaaoeiaaiaaaaadaaaadiiaacaaoeiaaeaaoeia
afaaaaadafaaciiaadaaaaiaaeaappkaabaaaaacabaaapiaaaaaoekaaeaaaaae
acaachiaacaaoekaafaaoeiaabaaoeibafaaaaadadaachiaafaaoeiaacaaoeka
aeaaaaaeabaachiaadaakkkaacaaoeiaabaaoeiaafaaaaadabaachiaabaaoeia
afaappiaaeaaaaaeabaaciiaadaakkkaabaappibabaappiaaeaaaaaeabaachia
adaaoeiaabaappiaabaaoeiaafaaaaadaaaachiaaaaaoeiaabaaoeiaafaaaaad
aaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiiaaeaakkkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefceeafaaaaeaaaaaaafbabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaad
icbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadpcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadbaaaaah
bcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaa
aaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaaacaaaaaa
egacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaa
dgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaadaaaaaa
dkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaaafaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabacaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamocaabaaaabaaaaaa
agijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaiaebaaaaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaafgaobaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaa
aaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaaaaaaaaaafgaobaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 31 math, 4 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 2 [_Color]
Float 4 [_Glossiness]
Vector 1 [_LightColor0]
Float 3 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_LightTexture0] CUBE 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_2_0
def c5, 1, 16, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5.xyz
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dp3_pp r0.w, t5, t5
mov_pp r0.xy, r0.w
nrm_pp r1.xyz, t4
dp3_pp r1.w, -t1, r1
add_pp r1.w, r1.w, r1.w
mad_pp r2.xyz, r1, -r1.w, -t1
mov_pp r3.x, t2.w
mov_pp r3.y, t3.w
mov_pp r3.z, t4.w
dp3_pp r1.w, r2, r3
mul_pp r1.w, r1.w, r1.w
mul_pp r2.x, r1.w, r1.w
mov r1.w, c5.x
add_pp r2.y, r1.w, -c4.x
texld r0, r0, s3
texld r4, t5, s2
texld r2, r2, s0
texld r5, t0, s1
mul_pp r1.w, r0.x, r4.w
mul_pp r0.xyz, r1.w, c1
dp3_sat_pp r0.w, r1, r3
mul_pp r5.w, r2.x, c5.y
mov r1, c0
mad_pp r2.xyz, c2, r5, -r1
mul_pp r3.xyz, r5, c2
mad_pp r1.xyz, c3.x, r2, r1
mul_pp r1.xyz, r1, r5.w
mad_pp r1.w, c3.x, -r1.w, r1.w
mad_pp r1.xyz, r3, r1.w, r1
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0.w, r0
mov_pp r0.w, c5.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math, 4 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTextureB0] 2D 3
SetTexture 2 [_LightTexture0] CUBE 2
SetTexture 3 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefieceddegekadcojmejolegikdcchfeoebfdplabaaaaaaoeafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmaeaaaaeaaaaaaaclabaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
adaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaad
hcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbcbaaaagaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaa
aaaaaaaaegbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaa
adaaaaaadgaaaaafccaabaaaadaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaa
adaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
ccaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadp
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaeb
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaamocaabaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaa
acaaaaaaagijcaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaa
kgikcaaaaaaaaaaaanaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaa
diaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaan
icaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaa
acaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaabaaaaaaagajbaaa
acaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaajgahbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 23 math, 4 textures
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTextureB0] 2D 3
SetTexture 2 [_LightTexture0] CUBE 2
SetTexture 3 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedefjdcpnblgmglfjfabobnjffdainoncaabaaaaaaomaiaaaaaeaaaaaa
daaaaaaadeadaaaaoiahaaaaliaiaaaaebgpgodjpmacaaaapmacaaaaaaacpppp
jiacaaaageaaaaaaaeaadeaaaaaageaaaaaageaaaeaaceaaaaaageaaadaaaaaa
aaababaaacacacaaabadadaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaaabaaabaa
aaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaaaaacpppp
fbaaaaafaeaaapkaaaaaiadpaaaaiaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaacplabpaaaaac
aaaaaaiaadaacplabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaaiaafaachla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaji
acaiapkabpaaaaacaaaaaajaadaiapkaaiaaaaadaaaaciiaafaaoelaafaaoela
abaaaaacaaaacdiaaaaappiaceaaaaacabaachiaaeaaoelaaiaaaaadabaaciia
abaaoelbabaaoeiaacaaaaadabaaciiaabaappiaabaappiaaeaaaaaeacaachia
abaaoeiaabaappibabaaoelbabaaaaacadaacbiaacaapplaabaaaaacadaaccia
adaapplaabaaaaacadaaceiaaeaapplaaiaaaaadabaaciiaacaaoeiaadaaoeia
afaaaaadabaaciiaabaappiaabaappiaafaaaaadacaacbiaabaappiaabaappia
abaaaaacaaaaamiaadaaoekaacaaaaadacaacciaaaaappibaeaaaakaecaaaaad
aeaaapiaaaaaoeiaadaioekaecaaaaadafaaapiaafaaoelaacaioekaecaaaaad
acaaapiaacaaoeiaaaaioekaecaaaaadagaaapiaaaaaoelaabaioekaafaaaaad
abaaciiaaeaaaaiaafaappiaafaaaaadacaacoiaabaappiaabaablkaaiaaaaad
agaadiiaabaaoeiaadaaoeiaafaaaaadaaaacbiaacaaaaiaaeaaffkaabaaaaac
abaaahiaaaaaoekaaeaaaaaeabaachiaacaaoekaagaaoeiaabaaoeibafaaaaad
adaachiaagaaoeiaacaaoekaaeaaaaaeabaachiaaaaakkiaabaaoeiaaaaaoeka
afaaaaadabaachiaaaaaaaiaabaaoeiaaeaaaaaeabaaciiaaaaakkiaaaaappkb
aaaappkaaeaaaaaeaaaachiaadaaoeiaabaappiaabaaoeiaafaaaaadaaaachia
acaabliaaaaaoeiaafaaaaadaaaachiaagaappiaaaaaoeiaabaaaaacaaaaciia
aeaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckmaeaaaaeaaaaaaa
clabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaaj
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegbcbaaaagaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaia
ebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaadaaaaaa
dkbabaaaadaaaaaadgaaaaafccaabaaaadaaaaaadkbabaaaaeaaaaaadgaaaaaf
ecaabaaaadaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajccaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiaebefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaa
agajbaaaacaaaaaaagijcaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalocaabaaa
abaaaaaakgikcaaaaaaaaaaaanaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaa
dcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaabaaaaaa
agajbaaaacaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
lmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 28 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 2 [_Color]
Float 4 [_Glossiness]
Vector 1 [_LightColor0]
Float 3 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
def c5, 1, 16, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
nrm_pp r0.xyz, t4
dp3_pp r0.w, -t1, r0
add_pp r0.w, r0.w, r0.w
mad_pp r1.xyz, r0, -r0.w, -t1
mov_pp r2.x, t2.w
mov_pp r2.y, t3.w
mov_pp r2.z, t4.w
dp3_pp r0.w, r1, r2
dp3_sat_pp r0.x, r0, r2
mul_pp r0.y, r0.w, r0.w
mul_pp r1.x, r0.y, r0.y
mov r2.x, c5.x
add_pp r1.y, r2.x, -c4.x
texld r1, r1, s0
texld r2, t0, s1
texld_pp r3, t5, s2
mul_pp r2.w, r1.x, c5.y
mov r1, c0
mad_pp r0.yzw, c2.wzyx, r2.wzyx, -r1.wzyx
mul_pp r2.xyz, r2, c2
mad_pp r0.yzw, c3.x, r0, r1.wzyx
mul_pp r0.yzw, r0, r2.w
mad_pp r2.w, c3.x, -r1.w, r1.w
mad_pp r0.yzw, r2.wzyx, r2.w, r0
mul_pp r1.xyz, r3.w, c1
mul_pp r0.yzw, r0, r1.wzyx
mul_pp r0.xyz, r0.x, r0.wzyx
mov_pp r0.w, c5.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 21 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlehfnaopcgbkgampdkkgfpefkegiakfmabaaaaaagmafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeaeaaaaeaaaaaaaanabaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gcbaaaaddcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaia
ebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaacaaaaaa
dkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaaf
ecaabaaaacaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaajccaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiaebefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaa
acaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaa
dcaaaaanicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
agajbaaaabaaaaaapgapbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaagaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 21 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjbicbiiimcdhhdjppndcpgmdkaccjlooabaaaaaaciaiaaaaaeaaaaaa
daaaaaaaoiacaaaaceahaaaapeahaaaaebgpgodjlaacaaaalaacaaaaaaacpppp
faacaaaagaaaaaaaaeaadaaaaaaagaaaaaaagaaaadaaceaaaaaagaaaacaaaaaa
aaababaaabacacaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaa
aaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaaaaacppppfbaaaaaf
aeaaapkaaaaaiadpaaaaiaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaia
adaacplabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaaiaafaacdlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
ceaaaaacaaaachiaaeaaoelaaiaaaaadaaaaciiaabaaoelbaaaaoeiaacaaaaad
aaaaciiaaaaappiaaaaappiaaeaaaaaeabaachiaaaaaoeiaaaaappibabaaoelb
abaaaaacacaacbiaacaapplaabaaaaacacaacciaadaapplaabaaaaacacaaceia
aeaapplaaiaaaaadaaaaciiaabaaoeiaacaaoeiaaiaaaaadaaaadbiaaaaaoeia
acaaoeiaafaaaaadaaaacciaaaaappiaaaaappiaafaaaaadabaacbiaaaaaffia
aaaaffiaabaaaaacaaaaamiaadaaoekaacaaaaadabaacciaaaaappibaeaaaaka
ecaaaaadabaaapiaabaaoeiaaaaioekaecaaaaadacaaapiaaaaaoelaabaioeka
ecaaaaadadaacpiaafaaoelaacaioekaafaaaaadacaaciiaabaaaaiaaeaaffka
abaaaaacabaaahiaaaaaoekaaeaaaaaeabaachiaacaaoekaacaaoeiaabaaoeib
afaaaaadacaachiaacaaoeiaacaaoekaaeaaaaaeabaachiaaaaakkiaabaaoeia
aaaaoekaafaaaaadabaachiaabaaoeiaacaappiaaeaaaaaeabaaciiaaaaakkia
aaaappkbaaaappkaaeaaaaaeaaaacoiaacaabliaabaappiaabaabliaafaaaaad
abaachiaadaappiaabaaoekaafaaaaadaaaacoiaaaaaoeiaabaabliaafaaaaad
aaaachiaaaaaaaiaaaaabliaabaaaaacaaaaciiaaeaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcdeaeaaaaeaaaaaaaanabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaa
gcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaaddcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
afaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaa
egbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaaadaaaaaa
dgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaacaaaaaa
dkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaajccaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiaebefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaamhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaaacaaaaaakgikcaaa
aaaaaaaaanaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaadcaaaaanicaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaa
dkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaa
pgapbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
agaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 37 math, 5 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 3 [_Color]
Float 5 [_Glossiness]
Vector 2 [_LightColor0]
Vector 0 [_LightShadowData]
Float 4 [_Metallic]
Vector 1 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
"ps_2_0
def c6, 0.5, 0, 1, 16
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5
dcl t6
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
rcp r0.w, t5.w
mad_pp r0.xy, t5, r0.w, c6.x
dp3_pp r1.w, t5, t5
mov_pp r1.xy, r1.w
nrm_pp r2.xyz, t4
dp3_pp r2.w, -t1, r2
add_pp r2.w, r2.w, r2.w
mad_pp r3.xyz, r2, -r2.w, -t1
mov_pp r4.x, t2.w
mov_pp r4.y, t3.w
mov_pp r4.z, t4.w
dp3_pp r2.w, r3, r4
mul_pp r2.w, r2.w, r2.w
mul_pp r3.x, r2.w, r2.w
mov r2.w, c6.z
add_pp r3.y, r2.w, -c5.x
texld_pp r0, r0, s3
texld_pp r1, r1, s4
texldp_pp r5, t6, s2
texld r3, r3, s0
texld r6, t0, s1
mul r4.w, r0.w, r1.x
cmp r4.w, -t5.z, c6.y, r4.w
lrp_pp r6.w, r5.x, r2.w, c0.x
mul_pp r2.w, r4.w, r6.w
mul_pp r0.xyz, r2.w, c2
dp3_sat_pp r0.w, r2, r4
mul_pp r6.w, r3.x, c6.w
mov r1, c1
mad_pp r2.xyz, c3, r6, -r1
mul_pp r3.xyz, r6, c3
mad_pp r1.xyz, c4.x, r2, r1
mul_pp r1.xyz, r1, r6.w
mad_pp r1.w, c4.x, -r1.w, r1.w
mad_pp r1.xyz, r3, r1.w, r1
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0.w, r0
mov r0.w, c6.z
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 32 math, 4 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 3
SetTexture 2 [_LightTextureB0] 2D 4
SetTexture 3 [unity_NHxRoughness] 2D 0
SetTexture 4 [_ShadowMapTexture] 2D 2
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedemcbcnjhmomdddhekkbgneendaamgpohabaaaaaahmahaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefccmagaaaaeaaaaaaailabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaiaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gcbaaaadpcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaagaaaaaa
pgbpbaaaagaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadbaaaaahbcaabaaaaaaaaaaa
abeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahocaabaaaaaaaaaaaagbjbaaaahaaaaaapgbpbaaaahaaaaaa
ehaaaaalccaabaaaaaaaaaaajgafbaaaaaaaaaaaaghabaaaaeaaaaaaaagabaaa
acaaaaaadkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaaakiacaiaebaaaaaa
abaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaia
ebaaaaaaacaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaaf
ccaabaaaadaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
bacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
ocaabaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaia
ebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaa
anaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaa
abaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaa
aaaaaaaaacaaaaaadcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaa
aaaaaaaafgaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
jgahbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 32 math, 4 textures
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [_LightTextureB0] 2D 3
SetTexture 3 [unity_NHxRoughness] 2D 0
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0_level_9_1
eefiecediejbjienhmkichbfcdhnnbkekkcafbnbabaaaaaaeealaaaaafaaaaaa
deaaaaaaoeadaaaabiakaaaaciakaaaabaalaaaaebgpgodjkiadaaaakiadaaaa
aaacppppdeadaaaaheaaaaaaafaadiaaaaaaheaaaaaaheaaafaaceaaaaaaheaa
apapaaaaadaaabaaaaabacaaabacadaaacadaeaaaaaaacaaabaaaaaaaaaaaaaa
aaaaagaaabaaabaaaaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaa
aaaaaaaaabaabiaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaadp
aaaaiadpaaaaaaaaaaaaiaebbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaiaadaacplabpaaaaac
aaaaaaiaaeaacplabpaaaaacaaaaaaiaafaacplabpaaaaacaaaaaaiaagaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaagaaaaac
aaaaaiiaafaapplaaeaaaaaeaaaacdiaafaaoelaaaaappiaafaaaakaaiaaaaad
abaaciiaafaaoelaafaaoelaabaaaaacabaacdiaabaappiaagaaaaacaaaaaeia
agaapplaafaaaaadacaaahiaaaaakkiaagaaoelaceaaaaacadaachiaaeaaoela
aiaaaaadacaaciiaabaaoelbadaaoeiaacaaaaadacaaciiaacaappiaacaappia
aeaaaaaeaeaachiaadaaoeiaacaappibabaaoelbabaaaaacafaacbiaacaappla
abaaaaacafaacciaadaapplaabaaaaacafaaceiaaeaapplaaiaaaaadacaaciia
aeaaoeiaafaaoeiaafaaaaadacaaciiaacaappiaacaappiaafaaaaadaeaacbia
acaappiaacaappiaabaaaaacacaaaiiaafaaffkaacaaaaadaeaacciaacaappia
adaappkbecaaaaadaaaacpiaaaaaoeiaadaioekaecaaaaadabaacpiaabaaoeia
aeaioekaecaaaaadagaacpiaacaaoeiaaaaioekaecaaaaadaeaaapiaaeaaoeia
abaioekaecaaaaadahaaapiaaaaaoelaacaioekaafaaaaadadaaaiiaaaaappia
abaaaaiabcaaaaaeafaaciiaagaaaaiaacaappiaaeaaaakaafaaaaadadaaaiia
adaappiaafaappiaafaaaaadaaaachiaadaappiaabaaoekafiaaaaaeaaaachia
afaakklbafaakkkaaaaaoeiaaiaaaaadaaaadiiaadaaoeiaafaaoeiaafaaaaad
ahaaciiaaeaaaaiaafaappkaabaaaaacabaaapiaaaaaoekaaeaaaaaeacaachia
acaaoekaahaaoeiaabaaoeibafaaaaadadaachiaahaaoeiaacaaoekaaeaaaaae
abaachiaadaakkkaacaaoeiaabaaoeiaafaaaaadabaachiaabaaoeiaahaappia
aeaaaaaeabaaciiaadaakkkaabaappibabaappiaaeaaaaaeabaachiaadaaoeia
abaappiaabaaoeiaafaaaaadaaaachiaaaaaoeiaabaaoeiaafaaaaadaaaachia
aaaappiaaaaaoeiaabaaaaacaaaaaiiaafaaffkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefccmagaaaaeaaaaaaailabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaiaaadaagabaaaapaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaapaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
adaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaad
pcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaagaaaaaapgbpbaaa
agaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaackbabaaaagaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
aoaaaaahocaabaaaaaaaaaaaagbjbaaaahaaaaaapgbpbaaaahaaaaaaehaaaaal
ccaabaaaaaaaaaaajgafbaaaaaaaaaaaaghabaaaapaaaaaaaagabaaaapaaaaaa
dkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaaakiacaiaebaaaaaaabaaaaaa
biaaaaaaabeaaaaaaaaaiadpdcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaadiaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaai
icaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaa
adaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabacaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaadkiacaia
ebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamocaabaaa
abaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaiaebaaaaaa
aaaaaaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaa
fgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaa
acaaaaaadcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaaaaaaaaaa
fgaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaa
iaaaaaaaaaaaaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
neaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaa
neaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 28 math, 3 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 2 [_Color]
Float 4 [_Glossiness]
Vector 1 [_LightColor0]
Float 3 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
def c5, 1, 16, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5
dcl_2d s0
dcl_2d s1
dcl_2d s2
nrm_pp r0.xyz, t4
dp3_pp r0.w, -t1, r0
add_pp r0.w, r0.w, r0.w
mad_pp r1.xyz, r0, -r0.w, -t1
mov_pp r2.x, t2.w
mov_pp r2.y, t3.w
mov_pp r2.z, t4.w
dp3_pp r0.w, r1, r2
dp3_sat_pp r0.x, r0, r2
mul_pp r0.y, r0.w, r0.w
mul_pp r1.x, r0.y, r0.y
mov r2.x, c5.x
add_pp r1.y, r2.x, -c4.x
texld r1, r1, s0
texld r2, t0, s1
texldp_pp r3, t5, s2
mul_pp r2.w, r1.x, c5.y
mov r1, c0
mad_pp r0.yzw, c2.wzyx, r2.wzyx, -r1.wzyx
mul_pp r2.xyz, r2, c2
mad_pp r0.yzw, c3.x, r0, r1.wzyx
mul_pp r0.yzw, r0, r2.w
mad_pp r2.w, c3.x, -r1.w, r1.w
mad_pp r0.yzw, r2.wzyx, r2.w, r0
mul_pp r1.xyz, r3.x, c1
mul_pp r0.yzw, r0, r1.wzyx
mul_pp r0.xyz, r0.x, r0.wzyx
mov_pp r0.w, c5.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 22 math, 3 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 2
SetTexture 2 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedknlanilikkgcekhcnonccdbeaeafigajabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaaeaaaaeaaaaaaabeabaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaia
ebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaacaaaaaa
dkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaaf
ecaabaaaacaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaajccaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiaebefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalhcaabaaa
acaaaaaakgikcaaaaaaaaaaaanaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaa
dcaaaaanicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaaaaaaaaa
agajbaaaabaaaaaapgapbaaaabaaaaaafgaobaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaa
abaaaaaaagaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 29 math, 4 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 2 [_Color]
Float 4 [_Glossiness]
Vector 1 [_LightColor0]
Float 3 [_Metallic]
Vector 0 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_2_0
def c5, 1, 16, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5.xy
dcl_pp t6
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
nrm_pp r0.xyz, t4
dp3_pp r0.w, -t1, r0
add_pp r0.w, r0.w, r0.w
mad_pp r1.xyz, r0, -r0.w, -t1
mov_pp r2.x, t2.w
mov_pp r2.y, t3.w
mov_pp r2.z, t4.w
dp3_pp r0.w, r1, r2
mul_pp r0.w, r0.w, r0.w
mul_pp r1.x, r0.w, r0.w
mov r0.w, c5.x
add_pp r1.y, r0.w, -c4.x
texld r3, t5, s3
texldp_pp r4, t6, s2
texld r1, r1, s0
texld r5, t0, s1
mul_pp r0.w, r3.w, r4.x
mul_pp r1.yzw, r0.w, c1.wzyx
dp3_sat_pp r5.w, r0, r2
mul_pp r0.x, r1.x, c5.y
mov r2, c0
mad_pp r0.yzw, c2.wzyx, r5.wzyx, -r2.wzyx
mul_pp r3.xyz, r5, c2
mad_pp r0.yzw, c3.x, r0, r2.wzyx
mul_pp r0.xyz, r0.wzyx, r0.x
mad_pp r0.w, c3.x, -r2.w, r2.w
mad_pp r0.xyz, r3, r0.w, r0
mul_pp r0.xyz, r1.wzyx, r0
mul_pp r0.xyz, r5.w, r0
mov_pp r0.w, c5.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 23 math, 4 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 3
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhfiiijnppaomnahibdjkgohhknkhajpaabaaaaaaaiagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcliaeaaaaeaaaaaaacoabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaad
icbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaaddcbabaaaagaaaaaa
gcbaaaadlcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaahaaaaaapgbpbaaaahaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaagaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaia
ebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaadaaaaaa
dkbabaaaadaaaaaadgaaaaafccaabaaaadaaaaaadkbabaaaaeaaaaaadgaaaaaf
ecaabaaaadaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajccaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiaebefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaa
agajbaaaacaaaaaaagijcaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalocaabaaa
abaaaaaakgikcaaaaaaaaaaaanaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaa
dcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaabaaaaaa
agajbaaaacaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 37 math, 4 textures
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 4 [_Color]
Float 6 [_Glossiness]
Vector 3 [_LightColor0]
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Float 5 [_Metallic]
Vector 2 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_ShadowMapTexture] CUBE 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_2_0
def c7, 0.970000029, 1, 16, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5.xyz
dcl t6.xyz
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dp3_pp r0.w, t5, t5
mov_pp r0.xy, r0.w
nrm_pp r1.xyz, t4
dp3_pp r1.w, -t1, r1
add_pp r1.w, r1.w, r1.w
mad_pp r2.xyz, r1, -r1.w, -t1
mov_pp r3.x, t2.w
mov_pp r3.y, t3.w
mov_pp r3.z, t4.w
dp3_pp r1.w, r2, r3
mul_pp r1.w, r1.w, r1.w
mul_pp r2.x, r1.w, r1.w
mov r1.w, c7.y
add_pp r2.y, r1.w, -c6.x
texld r4, t6, s2
texld r0, r0, s3
texld r2, r2, s0
texld r5, t0, s1
dp3 r3.w, t6, t6
rsq r3.w, r3.w
rcp r3.w, r3.w
mul r3.w, r3.w, c0.w
mad r3.w, r3.w, -c7.x, r4.x
cmp_pp r1.w, r3.w, r1.w, c1.x
mul_pp r1.w, r0.x, r1.w
mul_pp r0.xyz, r1.w, c3
dp3_sat_pp r0.w, r1, r3
mul_pp r5.w, r2.x, c7.z
mov r1, c2
mad_pp r2.xyz, c4, r5, -r1
mul_pp r3.xyz, r5, c4
mad_pp r1.xyz, c5.x, r2, r1
mul_pp r1.xyz, r1, r5.w
mad_pp r1.w, c5.x, -r1.w, r1.w
mad_pp r1.xyz, r3, r1.w, r1
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0.w, r0
mov_pp r0.w, c7.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 28 math, 4 textures
Keywords { "POINT" "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 3
SetTexture 2 [_ShadowMapTexture] CUBE 2
SetTexture 3 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedbecgcmklclhiaehigkhbcegknimdoicoabaaaaaaniagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefciiafaaaaeaaaaaaagcabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaad
icbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaomfbhidpefaaaaajpcaabaaaabaaaaaaegbcbaaaahaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaai
icaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaa
adaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabacaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaadkiacaia
ebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamocaabaaa
abaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaiaebaaaaaa
aaaaaaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaa
fgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaa
acaaaaaadcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaaaaaaaaaa
fgaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 28 math, 4 textures
Keywords { "POINT" "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 3
SetTexture 2 [_ShadowMapTexture] CUBE 2
SetTexture 3 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0_level_9_1
eefiecednmdkdihbejmbpeoocaigdjhihnkgkilcabaaaaaahaakaaaaaeaaaaaa
daaaaaaameadaaaafeajaaaadmakaaaaebgpgodjimadaaaaimadaaaaaaacpppp
baadaaaahmaaaaaaagaadeaaaaaahmaaaaaahmaaaeaaceaaaaaahmaaadaaaaaa
aaababaaacacacaaabadadaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaaabaaabaa
aaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaaabaaabaa
abaaaeaaaaaaaaaaacaabiaaabaaafaaaaaaaaaaaaacppppfbaaaaafagaaapka
omfbhidpaaaaiadpaaaaiaebaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaiaadaacpla
bpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaaiaafaachlabpaaaaacaaaaaaia
agaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajiacaiapkabpaaaaacaaaaaajaadaiapkaaiaaaaadaaaaciiaafaaoela
afaaoelaabaaaaacaaaacdiaaaaappiaceaaaaacabaachiaaeaaoelaaiaaaaad
abaaciiaabaaoelbabaaoeiaacaaaaadabaaciiaabaappiaabaappiaaeaaaaae
acaachiaabaaoeiaabaappibabaaoelbabaaaaacadaacbiaacaapplaabaaaaac
adaacciaadaapplaabaaaaacadaaceiaaeaapplaaiaaaaadabaaciiaacaaoeia
adaaoeiaafaaaaadabaaciiaabaappiaabaappiaafaaaaadacaacbiaabaappia
abaappiaabaaaaacaaaaamiaadaaoekaacaaaaadacaacciaaaaappibagaaffka
ecaaaaadaeaaapiaagaaoelaacaioekaecaaaaadafaaapiaaaaaoeiaadaioeka
ecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaadagaaapiaaaaaoelaabaioeka
aiaaaaadabaaaiiaagaaoelaagaaoelaahaaaaacabaaaiiaabaappiaagaaaaac
abaaaiiaabaappiaafaaaaadabaaaiiaabaappiaaeaappkaaeaaaaaeabaaaiia
abaappiaagaaaakbaeaaaaiaabaaaaacadaaaiiaagaaffkafiaaaaaeabaaciia
abaappiaadaappiaafaaaakaafaaaaadabaaciiaabaappiaafaaaaiaafaaaaad
acaacoiaabaappiaabaablkaaiaaaaadagaadiiaabaaoeiaadaaoeiaafaaaaad
aaaacbiaacaaaaiaagaakkkaabaaaaacabaaahiaaaaaoekaaeaaaaaeabaachia
acaaoekaagaaoeiaabaaoeibafaaaaadadaachiaagaaoeiaacaaoekaaeaaaaae
abaachiaaaaakkiaabaaoeiaaaaaoekaafaaaaadabaachiaaaaaaaiaabaaoeia
aeaaaaaeabaaciiaaaaakkiaaaaappkbaaaappkaaeaaaaaeaaaachiaadaaoeia
abaappiaabaaoeiaafaaaaadaaaachiaacaabliaaaaaoeiaafaaaaadaaaachia
agaappiaaaaaoeiaabaaaaacaaaaaiiaagaaffkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefciiafaaaaeaaaaaaagcabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaa
aeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
hcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaomfbhidpefaaaaajpcaabaaaabaaaaaaegbcbaaaahaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaa
aaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaaacaaaaaa
egacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaa
dgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaadaaaaaa
dkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaaafaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabacaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamocaabaaaabaaaaaa
agijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaiaebaaaaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaafgaobaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaa
aaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaaaaaaaaaafgaobaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 37 math, 5 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 4 [_Color]
Float 6 [_Glossiness]
Vector 3 [_LightColor0]
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Float 5 [_Metallic]
Vector 2 [unity_ColorSpaceDielectricSpec]
SetTexture 0 [unity_NHxRoughness] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_ShadowMapTexture] CUBE 2
SetTexture 3 [_LightTexture0] CUBE 3
SetTexture 4 [_LightTextureB0] 2D 4
"ps_2_0
def c7, 0.970000029, 1, 16, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t2
dcl_pp t3
dcl_pp t4
dcl_pp t5.xyz
dcl t6.xyz
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_cube s3
dcl_2d s4
texld r0, t6, s2
texld r1, t5, s3
texld r2, t0, s1
dp3 r2.w, t6, t6
rsq r2.w, r2.w
rcp r2.w, r2.w
mul r2.w, r2.w, c0.w
mad r2.w, r2.w, -c7.x, r0.x
mov r0.y, c7.y
cmp_pp r2.w, r2.w, r0.y, c1.x
dp3_pp r1.xy, t5, t5
nrm_pp r3.xyz, t4
dp3_pp r3.w, -t1, r3
add_pp r3.w, r3.w, r3.w
mad_pp r4.xyz, r3, -r3.w, -t1
mov_pp r5.x, t2.w
mov_pp r5.y, t3.w
mov_pp r5.z, t4.w
dp3_pp r3.w, r4, r5
mul_pp r3.w, r3.w, r3.w
mul_pp r4.x, r3.w, r3.w
add_pp r4.y, r0.y, -c6.x
texld r0, r1, s4
texld r4, r4, s0
mul r3.w, r1.w, r0.x
mul_pp r2.w, r2.w, r3.w
mul_pp r0.xyz, r2.w, c3
dp3_sat_pp r0.w, r3, r5
mul_pp r2.w, r4.x, c7.z
mov r1, c2
mad_pp r3.xyz, c4, r2, -r1
mul_pp r2.xyz, r2, c4
mad_pp r1.xyz, c5.x, r3, r1
mul_pp r1.xyz, r1, r2.w
mad_pp r1.w, c5.x, -r1.w, r1.w
mad_pp r1.xyz, r2, r1.w, r1
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0.w, r0
mov_pp r0.w, c7.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 29 math, 5 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTextureB0] 2D 4
SetTexture 2 [_LightTexture0] CUBE 3
SetTexture 3 [_ShadowMapTexture] CUBE 2
SetTexture 4 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedfolpepejiachcflbbgnhpblbmakfjhogabaaaaaadeahaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoeafaaaaeaaaaaaahjabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaa
acaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaa
aeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
hcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaomfbhidpefaaaaajpcaabaaaabaaaaaaegbcbaaaahaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaa
agaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaa
aaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaaacaaaaaa
egacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaa
dgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaadaaaaaa
dkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaaafaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabacaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamocaabaaaabaaaaaa
agijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaiaebaaaaaaaaaaaaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaafgaobaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaa
aaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaaaaaaaaaafgaobaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 29 math, 5 textures
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTextureB0] 2D 4
SetTexture 2 [_LightTexture0] CUBE 3
SetTexture 3 [_ShadowMapTexture] CUBE 2
SetTexture 4 [unity_NHxRoughness] 2D 0
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0_level_9_1
eefiecedgmkfaapimdjiagdejkdnkghcgojkbhbpabaaaaaaoeakaaaaaeaaaaaa
daaaaaaanmadaaaamiajaaaalaakaaaaebgpgodjkeadaaaakeadaaaaaaacpppp
ceadaaaaiaaaaaaaagaadiaaaaaaiaaaaaaaiaaaafaaceaaaaaaiaaaaeaaaaaa
aaababaaadacacaaacadadaaabaeaeaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaa
abaaabaaaaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaa
abaaabaaabaaaeaaaaaaaaaaacaabiaaabaaafaaaaaaaaaaaaacppppfbaaaaaf
agaaapkaomfbhidpaaaaiadpaaaaiaebaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaia
adaacplabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaaiaafaachlabpaaaaac
aaaaaaiaagaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajiacaiapkabpaaaaacaaaaaajiadaiapkabpaaaaacaaaaaaja
aeaiapkaecaaaaadaaaaapiaagaaoelaacaioekaecaaaaadabaaapiaafaaoela
adaioekaecaaaaadacaaapiaaaaaoelaabaioekaaiaaaaadacaaaiiaagaaoela
agaaoelaahaaaaacacaaaiiaacaappiaagaaaaacacaaaiiaacaappiaafaaaaad
acaaaiiaacaappiaaeaappkaaeaaaaaeacaaaiiaacaappiaagaaaakbaaaaaaia
abaaaaacaaaaaciaagaaffkafiaaaaaeacaaciiaacaappiaaaaaffiaafaaaaka
aiaaaaadabaacdiaafaaoelaafaaoelaceaaaaacadaachiaaeaaoelaaiaaaaad
adaaciiaabaaoelbadaaoeiaacaaaaadadaaciiaadaappiaadaappiaaeaaaaae
aeaachiaadaaoeiaadaappibabaaoelbabaaaaacafaacbiaacaapplaabaaaaac
afaacciaadaapplaabaaaaacafaaceiaaeaapplaaiaaaaadadaaciiaaeaaoeia
afaaoeiaafaaaaadadaaciiaadaappiaadaappiaafaaaaadaeaacbiaadaappia
adaappiaacaaaaadaeaacciaaaaaffiaadaappkbecaaaaadaaaaapiaabaaoeia
aeaioekaecaaaaadaeaaapiaaeaaoeiaaaaioekaafaaaaadadaaaiiaabaappia
aaaaaaiaafaaaaadacaaciiaacaappiaadaappiaafaaaaadaaaachiaacaappia
abaaoekaaiaaaaadaaaadiiaadaaoeiaafaaoeiaafaaaaadacaaciiaaeaaaaia
agaakkkaabaaaaacabaaapiaaaaaoekaaeaaaaaeadaachiaacaaoekaacaaoeia
abaaoeibafaaaaadacaachiaacaaoeiaacaaoekaaeaaaaaeabaachiaadaakkka
adaaoeiaabaaoeiaafaaaaadabaachiaabaaoeiaacaappiaaeaaaaaeabaaciia
adaakkkaabaappibabaappiaaeaaaaaeabaachiaacaaoeiaabaappiaabaaoeia
afaaaaadaaaachiaaaaaoeiaabaaoeiaafaaaaadaaaachiaaaaappiaaaaaoeia
abaaaaacaaaaaiiaagaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
oeafaaaaeaaaaaaahjabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaa
acaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
ahaaaaaaegbcbaaaahaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaomfbhidpefaaaaaj
pcaabaaaabaaaaaaegbcbaaaahaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaa
dbaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaadhaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaaabeaaaaa
aaaaiadpbaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaagaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
acaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaia
ebaaaaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaadgaaaaafbcaabaaaadaaaaaa
dkbabaaaadaaaaaadgaaaaafccaabaaaadaaaaaadkbabaaaaeaaaaaadgaaaaaf
ecaabaaaadaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajccaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiaebefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamocaabaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaa
agajbaaaacaaaaaaagijcaiaebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaalocaabaaa
abaaaaaakgikcaaaaaaaaaaaanaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaa
dcaaaaanicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaa
aaaaaaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajocaabaaaabaaaaaa
agajbaaaacaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaabejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
neaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaa
neaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "d3d11_9x " {
// Stats: 23 math, 2 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [unity_NHxRoughness] 2D 0
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 256
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0_level_9_1
eefiecedjloedpjfbnleinailgpccakjkljiklllabaaaaaammaiaaaaafaaaaaa
deaaaaaabiadaaaaliahaaaamiahaaaajiaiaaaaebgpgodjnmacaaaanmacaaaa
aaacpppphaacaaaagmaaaaaaafaadaaaaaaagmaaaaaagmaaadaaceaaaaaagmaa
apapaaaaabaaabaaaaabacaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaaabaaabaa
aaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaaabaabiaa
abaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaiadpaaaaiaebaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaacplabpaaaaacaaaaaaiaadaacplabpaaaaacaaaaaaiaaeaacpla
bpaaaaacaaaaaaiaafaacplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaceaaaaacaaaachiaaeaaoelaaiaaaaad
aaaaciiaabaaoelbaaaaoeiaacaaaaadaaaaciiaaaaappiaaaaappiaaeaaaaae
abaachiaaaaaoeiaaaaappibabaaoelbabaaaaacacaacbiaacaapplaabaaaaac
acaacciaadaapplaabaaaaacacaaceiaaeaapplaaiaaaaadaaaaciiaabaaoeia
acaaoeiaafaaaaadaaaaciiaaaaappiaaaaappiaafaaaaadabaacbiaaaaappia
aaaappiaabaaaaacabaaamiaadaaoekaacaaaaadabaacciaabaappibafaaaaka
ecaaaaadadaacpiaafaaoelaaaaioekaecaaaaadaeaaapiaabaaoeiaabaioeka
ecaaaaadafaaapiaaaaaoelaacaioekaabaaaaacaaaaaiiaafaaaakabcaaaaae
acaaciiaadaaaaiaaaaappiaaeaaaakaafaaaaadadaachiaacaappiaabaaoeka
aiaaaaadadaadiiaaaaaoeiaacaaoeiaafaaaaadafaaciiaaeaaaaiaafaaffka
abaaaaacaaaaahiaaaaaoekaaeaaaaaeaaaachiaacaaoekaafaaoeiaaaaaoeib
afaaaaadacaachiaafaaoeiaacaaoekaaeaaaaaeaaaachiaabaakkiaaaaaoeia
aaaaoekaafaaaaadaaaachiaaaaaoeiaafaappiaaeaaaaaeaaaaciiaabaakkia
aaaappkbaaaappkaaeaaaaaeaaaachiaacaaoeiaaaaappiaaaaaoeiaafaaaaad
aaaachiaadaaoeiaaaaaoeiaafaaaaadaaaachiaadaappiaaaaaoeiaabaaaaac
aaaaciiaafaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjiaeaaaa
eaaaaaaacgabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaa
abaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaiaaadaagabaaaapaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaapaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaa
gcbaaaadicbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaehaaaaalbcaabaaa
aaaaaaaaegbabaaaagaaaaaaaghabaaaapaaaaaaaagabaaaapaaaaaackbabaaa
agaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaiaebaaaaaaabaaaaaabiaaaaaa
abeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaabiaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaai
icaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaiaebaaaaaa
acaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaa
adaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaaafaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabacaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaadkiacaia
ebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamocaabaaa
abaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaiaebaaaaaa
aaaaaaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaaanaaaaaa
fgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaaaaaaaaaa
acaaaaaadcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaaaaaaaaaa
fgaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaa
iaaaaaaaaaaaaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
lmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaalmaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "d3d11_9x " {
// Stats: 24 math, 3 textures
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 2
SetTexture 2 [unity_NHxRoughness] 2D 0
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 320
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 216 [_Metallic]
Float 220 [_Glossiness]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0_level_9_1
eefiecedifjpihhjffnfhabnkdjpmnklacebdfjlabaaaaaaiiajaaaaafaaaaaa
deaaaaaafeadaaaafmaiaaaagmaiaaaafeajaaaaebgpgodjbiadaaaabiadaaaa
aaacppppkiacaaaahaaaaaaaafaadeaaaaaahaaaaaaahaaaaeaaceaaaaaahaaa
apapaaaaacaaabaaaaabacaaabacadaaaaaaacaaabaaaaaaaaaaaaaaaaaaagaa
abaaabaaaaaaaaaaaaaaajaaabaaacaaaaaaaaaaaaaaanaaabaaadaaaaaaaaaa
abaabiaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaiadpaaaaiaeb
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaiaadaacplabpaaaaacaaaaaaia
aeaacplabpaaaaacaaaaaaiaafaacdlabpaaaaacaaaaaaiaagaacplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkaceaaaaacaaaachiaaeaaoelaaiaaaaadaaaaciia
abaaoelbaaaaoeiaacaaaaadaaaaciiaaaaappiaaaaappiaaeaaaaaeabaachia
aaaaoeiaaaaappibabaaoelbabaaaaacacaacbiaacaapplaabaaaaacacaaccia
adaapplaabaaaaacacaaceiaaeaapplaaiaaaaadaaaaciiaabaaoeiaacaaoeia
afaaaaadaaaaciiaaaaappiaaaaappiaafaaaaadabaacbiaaaaappiaaaaappia
abaaaaacabaaamiaadaaoekaacaaaaadabaacciaabaappibafaaaakaecaaaaad
adaacpiaagaaoelaaaaioekaecaaaaadaeaaapiaafaaoelaadaioekaecaaaaad
afaaapiaabaaoeiaabaioekaecaaaaadagaaapiaaaaaoelaacaioekaabaaaaac
aaaaaiiaafaaaakabcaaaaaeacaaciiaadaaaaiaaaaappiaaeaaaakaafaaaaad
aaaaciiaacaappiaaeaappiaafaaaaadadaachiaaaaappiaabaaoekaaiaaaaad
adaadiiaaaaaoeiaacaaoeiaafaaaaadagaaciiaafaaaaiaafaaffkaabaaaaac
aaaaahiaaaaaoekaaeaaaaaeaaaachiaacaaoekaagaaoeiaaaaaoeibafaaaaad
acaachiaagaaoeiaacaaoekaaeaaaaaeaaaachiaabaakkiaaaaaoeiaaaaaoeka
afaaaaadaaaachiaaaaaoeiaagaappiaaeaaaaaeaaaaciiaabaakkiaaaaappkb
aaaappkaaeaaaaaeaaaachiaacaaoeiaaaaappiaaaaaoeiaafaaaaadaaaachia
adaaoeiaaaaaoeiaafaaaaadaaaachiaadaappiaaaaaoeiaabaaaaacaaaaciia
afaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcaaafaaaaeaaaaaaa
eaabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
bjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaiaaadaagabaaaapaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaapaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaadaaaaaagcbaaaadicbabaaa
aeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaaddcbabaaaagaaaaaagcbaaaad
hcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaehaaaaal
bcaabaaaaaaaaaaaegbabaaaahaaaaaaaghabaaaapaaaaaaaagabaaaapaaaaaa
ckbabaaaahaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaiaebaaaaaaabaaaaaa
biaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaagaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaa
baaaaaaiicaabaaaaaaaaaaaegbcbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
hcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegbcbaia
ebaaaaaaacaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaaf
ccaabaaaadaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
bacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiaebefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
ocaabaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaaagajbaaaacaaaaaaagijcaia
ebaaaaaaaaaaaaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaalocaabaaaabaaaaaakgikcaaaaaaaaaaa
anaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaa
abaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaanicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaacaaaaaadkiacaaa
aaaaaaaaacaaaaaadcaaaaajocaabaaaabaaaaaaagajbaaaacaaaaaapgapbaaa
aaaaaaaafgaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
jgahbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejda
aiaaaaaaiaaaaaaaaaaaaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 25 avg math (9..41)
 //    d3d11_9x : 25 avg math (9..41)
 //        d3d9 : 25 avg math (8..43)
 //      opengl : 2 avg math (1..3)
 // Stats for Fragment shader:
 //       d3d11 : 3 math
 //    d3d11_9x : 3 math
 //        d3d9 : 4 avg math (3..5)
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  GpuProgramID 505763
Program "vp" {
SubProgram "opengl " {
// Stats: 1 math
Keywords { "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_LightShadowBias;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform mat4 unity_MatrixVP;
void main ()
{
  vec3 vertex_1;
  vertex_1 = gl_Vertex.xyz;
  vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    vec3 tmpvar_4;
    tmpvar_4 = (_Object2World * tmpvar_3).xyz;
    vec4 v_5;
    v_5.x = _World2Object[0].x;
    v_5.y = _World2Object[1].x;
    v_5.z = _World2Object[2].x;
    v_5.w = _World2Object[3].x;
    vec4 v_6;
    v_6.x = _World2Object[0].y;
    v_6.y = _World2Object[1].y;
    v_6.z = _World2Object[2].y;
    v_6.w = _World2Object[3].y;
    vec4 v_7;
    v_7.x = _World2Object[0].z;
    v_7.y = _World2Object[1].z;
    v_7.z = _World2Object[2].z;
    v_7.w = _World2Object[3].z;
    vec3 tmpvar_8;
    tmpvar_8 = normalize(((
      (v_5.xyz * gl_Normal.x)
     + 
      (v_6.xyz * gl_Normal.y)
    ) + (v_7.xyz * gl_Normal.z)));
    float tmpvar_9;
    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_10);
  } else {
    vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = vertex_1;
    clipPos_2 = (gl_ModelViewProjectionMatrix * tmpvar_11);
  };
  vec4 clipPos_12;
  clipPos_12.xyw = clipPos_2.xyw;
  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_12;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 43 math
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_MatrixVP]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_LightShadowBias]
"vs_2_0
def c16, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
mul r0.x, c15.z, c15.z
slt r0.x, -r0.x, r0.x
mul r0.yzw, v1.y, c12.xxyz
mad r0.yzw, c11.xxyz, v1.x, r0
mad r0.yzw, c13.xxyz, v1.z, r0
nrm r1.xyz, r0.yzww
mad r2, v0.xyzx, c16.xxxy, c16.yyyx
dp4 r3.x, c8, r2
dp4 r3.y, c9, r2
dp4 r3.z, c10, r2
mad r0.yzw, r3.xxyz, -c14.w, c14.xxyz
nrm r4.xyz, r0.yzww
dp3 r0.y, r1, r4
mad r0.y, r0.y, -r0.y, c16.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.y, c15.z
mad r1.xyz, r1, -r0.y, r3
mov r1.w, c16.x
dp4 r3.x, c4, r1
dp4 r3.y, c5, r1
dp4 r3.z, c6, r1
dp4 r3.w, c7, r1
dp4 r1.x, c0, r2
dp4 r1.y, c1, r2
dp4 r1.z, c2, r2
dp4 r1.w, c3, r2
lrp r2, r0.x, r3, r1
rcp r0.x, r2.w
mul r0.x, r0.x, c15.x
max r0.x, r0.x, c16.y
min r0.x, r0.x, c16.x
add r0.x, r0.x, r2.z
max r0.y, r0.x, c16.y
lrp r2.z, c15.y, r0.y, r0.x
mov oT0, r2
mov oPos, r2

"
}
SubProgram "d3d11 " {
// Stats: 41 math
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 80 [unity_LightShadowBias]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityPerFrame" 256
Matrix 144 [unity_MatrixVP]
BindCB  "UnityLighting" 0
BindCB  "UnityShadows" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityPerFrame" 3
"vs_4_0
eefiecedkofcienalkjfdbfghdeacmmpolplmbnoabaaaaaamaagaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafdeieefcoeafaaaaeaaaabaa
hjabaaaafjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaa
anaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagiaaaaacadaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaabaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaabaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaabaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaabaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaabaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaabaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
abaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
abaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
abaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
pgipcaaaaaaaaaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
akaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaajaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
alaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaacaaaaaa
adaaaaaadjaaaaaibcaabaaaacaaaaaackiacaaaabaaaaaaafaaaaaaabeaaaaa
aaaaaaaadhaaaaajpcaabaaaaaaaaaaaagaabaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaocaaaaibcaabaaaabaaaaaaakiacaaaabaaaaaaafaaaaaa
dkaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaadgaaaaaflccabaaaaaaaaaaaegambaaaaaaaaaaadeaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakeccabaaaaaaaaaaa
bkiacaaaabaaaaaaafaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 41 math
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 80 [unity_LightShadowBias]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityPerFrame" 256
Matrix 144 [unity_MatrixVP]
BindCB  "UnityLighting" 0
BindCB  "UnityShadows" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityPerFrame" 3
"vs_4_0_level_9_1
eefiecedhlmpocbpldhhkipbpfieojpgcmiaogkfabaaaaaafaakaaaaaeaaaaaa
daaaaaaalmadaaaakiajaaaabmakaaaaebgpgodjieadaaaaieadaaaaaaacpopp
caadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaaaaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
acaaamaaahaaahaaaaaaaaaaadaaajaaaeaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaabiaabaaaajaalaaaaka
afaaaaadaaaaaciaabaaaajaamaaaakaafaaaaadaaaaaeiaabaaaajaanaaaaka
afaaaaadabaaabiaabaaffjaalaaffkaafaaaaadabaaaciaabaaffjaamaaffka
afaaaaadabaaaeiaabaaffjaanaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaabaakkjaalaakkkaafaaaaadabaaaciaabaakkjaamaakkka
afaaaaadabaaaeiaabaakkjaanaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaahiaaaaaffjaaiaaoekaaeaaaaae
aaaaahiaahaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaajaaoekaaaaakkja
aaaaoeiaacaaaaadaaaaahiaaaaaoeiaakaaoekaaeaaaaaeacaaahiaaaaaoeia
abaappkbabaaoekaceaaaaacadaaahiaacaaoeiaaiaaaaadaaaaaiiaabaaoeia
adaaoeiaaeaaaaaeaaaaaiiaaaaappiaaaaappibbcaaaakaahaaaaacaaaaaiia
aaaappiaagaaaaacaaaaaiiaaaaappiaafaaaaadaaaaaiiaaaaappiaacaakkka
aeaaaaaeaaaaahiaabaaoeiaaaaappibaaaaoeiaafaaaaadabaaapiaaaaaffia
apaaoekaaeaaaaaeabaaapiaaoaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapia
baaaoekaaaaakkiaabaaoeiaacaaaaadaaaaapiaaaaaoeiabbaaoekaafaaaaad
abaaapiaaaaaffjaaeaaoekaaeaaaaaeabaaapiaadaaoekaaaaaaajaabaaoeia
aeaaaaaeabaaapiaafaaoekaaaaakkjaabaaoeiaacaaaaadabaaapiaabaaoeia
agaaoekaafaaaaadacaaabiaacaakkkaacaakkkaamaaaaadacaaabiaacaaaaib
acaaaaiabcaaaaaeadaaapiaacaaaaiaaaaaoeiaabaaoeiaagaaaaacaaaaabia
adaappiaafaaaaadaaaaabiaaaaaaaiaacaaaakaalaaaaadaaaaabiaaaaaaaia
bcaaffkaakaaaaadaaaaabiaaaaaaaiabcaaaakaacaaaaadaaaaabiaaaaaaaia
adaakkiaalaaaaadaaaaaciaaaaaaaiabcaaffkaacaaaaadaaaaaciaaaaaaaib
aaaaffiaaeaaaaaeaaaaaemaacaaffkaaaaaffiaaaaaaaiaaeaaaaaeaaaaadma
adaappiaaaaaoekaadaaoeiaabaaaaacaaaaaimaadaappiappppaaaafdeieefc
oeafaaaaeaaaabaahjabaaaafjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaae
egiocaaaadaaaaaaanaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadhcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagiaaaaacadaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaabaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaabaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaabaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaabaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaabaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaabaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaabaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaapgipcaaaaaaaaaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaabaaaaaa
afaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaadaaaaaaakaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
ajaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaalaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaadiaaaaai
pcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaacaaaaaaadaaaaaadjaaaaaibcaabaaaacaaaaaackiacaaaabaaaaaa
afaaaaaaabeaaaaaaaaaaaaadhaaaaajpcaabaaaaaaaaaaaagaabaaaacaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaaocaaaaibcaabaaaabaaaaaaakiacaaa
abaaaaaaafaaaaaadkaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaaflccabaaaaaaaaaaaegambaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
bcaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
eccabaaaaaaaaaaabkiacaaaabaaaaaaafaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapahaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaa
faepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaa"
}
SubProgram "opengl " {
// Stats: 3 math
Keywords { "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  xlv_TEXCOORD0 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = vec4((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) * _LightPositionRange.w));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 7 [_LightPositionRange]
"vs_2_0
dcl_position v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add oT0.xyz, r0, -c7
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0

"
}
SubProgram "d3d11 " {
// Stats: 9 math
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmgkmdmiimpgfbbeijlbbhnckjdimdhfoabaaaaaalaacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaahaiaaaaebaaaaaaaaaaaaaaabaaaaaaadaaaaaaabaaaaaaapaaaaaa
feeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaklklklfdeieefclaabaaaa
eaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaagfaaaaadhccabaaaaaaaaaaa
ghaaaaaepccabaaaabaaaaaaabaaaaaagiaaaaacabaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 9 math
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedajmomlnjfihenbneealfggocokccfjgbabaaaaaaoeadaaaaaeaaaaaa
daaaaaaagaabaaaabiadaaaaimadaaaaebgpgodjciabaaaaciabaaaaaaacpopp
nmaaaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaaeaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjaafaaaaadaaaaahiaaaaaffja
ahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaajaaoekaaaaappjaaaaaoeia
acaaaaadaaaaahoaaaaaoeiaabaaoekbafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaagfaaaaad
hccabaaaaaaaaaaaghaaaaaepccabaaaabaaaaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadaaaaaafaepfdejfeejepeoaaeoepfcenebemaa
feeffiedepepfceeaaklklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaahaiaaaaebaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeo
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 3 math
Keywords { "SHADOWS_DEPTH" }
"ps_2_0
dcl t0
rcp r0.w, t0.w
mul_pp r0, r0.w, t0.z
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
"ps_4_0
eefiecednmfgmafnpgdjlbeekdafekgfpapnijkfabaaaaaalaaaaaaaadaaaaaa
cmaaaaaadmaaaaaahaaaaaaaejfdeheoaiaaaaaaaaaaaaaaaiaaaaaaepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaaaoaaaaaa
gfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_DEPTH" }
"ps_4_0_level_9_1
eefiecedbbbiincpfipkmkecghhijjileenegjaoabaaaaaabiabaaaaaeaaaaaa
daaaaaaajeaaaaaaneaaaaaaoeaaaaaaebgpgodjfmaaaaaafmaaaaaaaaacpppp
diaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaacaaaacpia
aaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabejfdeheoaiaaaaaaaaaaaaaa
aiaaaaaaepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 5 math
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
"ps_2_0
dcl t0.xyz
dp3 r0.w, t0, t0
rsq r0.x, r0.w
rcp r0.x, r0.x
mul_pp r0, r0.x, c0.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
// Stats: 3 math
Keywords { "SHADOWS_CUBE" }
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
BindCB  "UnityLighting" 0
"ps_4_0
eefiecedfnmflbfjaemdcoihgjpopakokhefifnoabaaaaaaciabaaaaadaaaaaa
cmaaaaaagaaaaaaajeaaaaaaejfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaahahaaaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimaaaaaaeaaaaaaa
cdaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaagcbaaaadhcbabaaaaaaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaaaaaaaaegbcbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaipccabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 3 math
Keywords { "SHADOWS_CUBE" }
ConstBuffer "UnityLighting" 720
Vector 16 [_LightPositionRange]
BindCB  "UnityLighting" 0
"ps_4_0_level_9_1
eefiecedmaohbkicjifghfadpaadmoobdecckpgjabaaaaaalmabaaaaaeaaaaaa
daaaaaaamaaaaaaafeabaaaaiiabaaaaebgpgodjiiaaaaaaiiaaaaaaaaacpppp
fiaaaaaadaaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaaaaadaaaaaaaabaa
abaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaahlaaiaaaaadaaaaaiia
aaaaoelaaaaaoelaahaaaaacaaaaabiaaaaappiaagaaaaacaaaaabiaaaaaaaia
afaaaaadaaaacpiaaaaaaaiaaaaappkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcimaaaaaaeaaaaaaacdaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
gcbaaaadhcbabaaaaaaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaipccabaaaaaaaaaaaagaabaaa
aaaaaaaapgipcaaaaaaaaaaaabaaaaaadoaaaaabejfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaahahaaaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "VertexLit"
}
