// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TME/Scroller"
{
	Properties
	{
		_LED_Example_d("LED_Example_d", 2D) = "white" {}
		_Speed("Speed", Vector) = (0.2,0,0,0)
		_Brightness("Brightness", Float) = 3
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Brightness;
		uniform sampler2D _LED_Example_d;
		uniform float2 _Speed;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 panner12 = ( _Time.y * _Speed + i.uv_texcoord);
			float4 temp_output_4_0 = ( _Brightness * tex2D( _LED_Example_d, panner12 ) );
			o.Albedo = temp_output_4_0.rgb;
			o.Emission = temp_output_4_0.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18921
382;166;1548;1020;1391.75;786.343;1.233188;True;True
Node;AmplifyShaderEditor.Vector2Node;16;-1157.53,18.19875;Inherit;False;Property;_Speed;Speed;1;0;Create;True;0;0;0;False;0;False;0.2,0;0.01,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-1209.996,-114.4009;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;19;-1175.617,151.101;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;12;-913.6237,22.31327;Inherit;False;3;0;FLOAT2;1,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;22;-512.3989,-28.00122;Inherit;True;Property;_LED_Example_d;LED_Example_d;0;0;Create;True;0;0;0;False;0;False;-1;56d6ce40bae0f494ea5ae815d5618ecb;56d6ce40bae0f494ea5ae815d5618ecb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-231.326,-156.1863;Inherit;False;Property;_Brightness;Brightness;2;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-53.59991,-26.90021;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;408,-191;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;TME/Scroller;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;21;0
WireConnection;12;2;16;0
WireConnection;12;1;19;0
WireConnection;22;1;12;0
WireConnection;4;0;24;0
WireConnection;4;1;22;0
WireConnection;0;0;4;0
WireConnection;0;2;4;0
ASEEND*/
//CHKSM=CBCA1C7CBF300F62D8A696D4E446690911BE0EDE