// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TME/TwoSided_Basic"
{
	Properties
	{
		_FrontFaceColor("FrontFace Color", Color) = (0.7735849,0,0,1)
		_BackFaceColor("BackFace Color", Color) = (0,0.3002812,0.8018868,1)
		_FrontFaceMetallic("FrontFace Metallic", Range( 0 , 1)) = 0
		_BackFaceMetallic("BackFace Metallic", Range( 0 , 1)) = 0
		_FrontFaceSmoothness("FrontFace Smoothness", Range( 0 , 1)) = 0
		_BackFaceSmoothness("BackFace Smoothness", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" }
		Cull Off
		Stencil
		{
			Ref 1
			CompFront Always
			PassFront Replace
		}
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldNormal;
			float3 viewDir;
		};

		uniform float4 _FrontFaceColor;
		uniform float4 _BackFaceColor;
		uniform float _FrontFaceMetallic;
		uniform float _BackFaceMetallic;
		uniform float _FrontFaceSmoothness;
		uniform float _BackFaceSmoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = i.worldNormal;
			float dotResult20 = dot( ase_worldNormal , i.viewDir );
			float temp_output_23_0 = (1.0 + (sign( dotResult20 ) - -1.0) * (0.0 - 1.0) / (1.0 - -1.0));
			float4 lerpResult24 = lerp( _FrontFaceColor , _BackFaceColor , temp_output_23_0);
			o.Albedo = lerpResult24.rgb;
			float lerpResult53 = lerp( _FrontFaceMetallic , _BackFaceMetallic , temp_output_23_0);
			o.Metallic = lerpResult53;
			float lerpResult60 = lerp( _FrontFaceSmoothness , _BackFaceSmoothness , temp_output_23_0);
			o.Smoothness = lerpResult60;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = worldViewDir;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18935
85;239;1813;1049;1092.689;811.171;1.291642;True;True
Node;AmplifyShaderEditor.CommentaryNode;49;-812.6159,136.8227;Inherit;False;837.131;394.4268;Comment;5;23;22;20;41;19;Switch (0 = Front | 1 = Back);1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;19;-737.396,355.2509;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;41;-762.6159,186.8232;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;20;-504.3648,281.9447;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;56;-272.4127,-441.7933;Inherit;False;292.4;241.7;Comment;2;55;54;Metallic;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;52;-260.5221,-955.3415;Inherit;False;276.3483;450.1422;Comment;2;29;28;Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.SignOpNode;22;-336.8129,293.5573;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-271.1141,-147.3444;Inherit;False;292.4;241.7;Comment;2;59;58;Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;28;-222.7417,-897.7762;Float;False;Property;_FrontFaceColor;FrontFace Color;1;0;Create;True;0;0;0;False;0;False;0.7735849,0,0,1;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-251.611,-381.9916;Inherit;False;Property;_FrontFaceMetallic;FrontFace Metallic;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-250.3124,-87.5427;Inherit;False;Property;_FrontFaceSmoothness;FrontFace Smoothness;5;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-249.0111,-293.5926;Inherit;False;Property;_BackFaceMetallic;BackFace Metallic;4;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-247.7125,0.8562393;Inherit;False;Property;_BackFaceSmoothness;BackFace Smoothness;6;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;29;-215.3423,-716.3939;Float;False;Property;_BackFaceColor;BackFace Color;2;0;Create;True;0;0;0;False;0;False;0,0.3002812,0.8018868,1;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;23;-174.3103,275.3966;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;53;250.1897,-350.7921;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;60;251.4885,-125.2434;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;24;249.9309,-519.0877;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;636.7381,-208.2437;Float;False;True;-1;2;;0;0;Standard;TME/TwoSided_Basic;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;True;1;False;-1;255;False;-1;255;False;-1;7;False;-1;3;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;1,0.4344827,0,0;VertexScale;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;41;0
WireConnection;20;1;19;0
WireConnection;22;0;20;0
WireConnection;23;0;22;0
WireConnection;53;0;54;0
WireConnection;53;1;55;0
WireConnection;53;2;23;0
WireConnection;60;0;58;0
WireConnection;60;1;59;0
WireConnection;60;2;23;0
WireConnection;24;0;28;0
WireConnection;24;1;29;0
WireConnection;24;2;23;0
WireConnection;0;0;24;0
WireConnection;0;3;53;0
WireConnection;0;4;60;0
ASEEND*/
//CHKSM=4D769D072B74709031762A4738D315638FA66B41