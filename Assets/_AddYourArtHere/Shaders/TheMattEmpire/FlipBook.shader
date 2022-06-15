// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TME/FlipBook"
{
	Properties
	{
		_LED_Example_d("LED_Example_d", 2D) = "white" {}
		_StartFrame("StartFrame", Float) = 0
		_Tiles("Tiles", Float) = 5
		_Speed("Speed", Float) = 2
		_Brightness("Brightness", Float) = 2
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
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Brightness;
		uniform sampler2D _LED_Example_d;
		uniform float _Tiles;
		uniform float _Speed;
		uniform float _StartFrame;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			// *** BEGIN Flipbook UV Animation vars ***
			// Total tiles of Flipbook Texture
			float fbtotaltiles2 = _Tiles * _Tiles;
			// Offsets for cols and rows of Flipbook Texture
			float fbcolsoffset2 = 1.0f / _Tiles;
			float fbrowsoffset2 = 1.0f / _Tiles;
			// Speed of animation
			float fbspeed2 = _Time.y * _Speed;
			// UV Tiling (col and row offset)
			float2 fbtiling2 = float2(fbcolsoffset2, fbrowsoffset2);
			// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
			// Calculate current tile linear index
			float fbcurrenttileindex2 = round( fmod( fbspeed2 + _StartFrame, fbtotaltiles2) );
			fbcurrenttileindex2 += ( fbcurrenttileindex2 < 0) ? fbtotaltiles2 : 0;
			// Obtain Offset X coordinate from current tile linear index
			float fblinearindextox2 = round ( fmod ( fbcurrenttileindex2, _Tiles ) );
			// Multiply Offset X by coloffset
			float fboffsetx2 = fblinearindextox2 * fbcolsoffset2;
			// Obtain Offset Y coordinate from current tile linear index
			float fblinearindextoy2 = round( fmod( ( fbcurrenttileindex2 - fblinearindextox2 ) / _Tiles, _Tiles ) );
			// Reverse Y to get tiles from Top to Bottom
			fblinearindextoy2 = (int)(_Tiles-1) - fblinearindextoy2;
			// Multiply Offset Y by rowoffset
			float fboffsety2 = fblinearindextoy2 * fbrowsoffset2;
			// UV Offset
			float2 fboffset2 = float2(fboffsetx2, fboffsety2);
			// Flipbook UV
			half2 fbuv2 = i.uv_texcoord * fbtiling2 + fboffset2;
			// *** END Flipbook UV Animation vars ***
			float4 temp_output_12_0 = ( _Brightness * tex2D( _LED_Example_d, fbuv2 ) );
			o.Albedo = temp_output_12_0.rgb;
			o.Emission = temp_output_12_0.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18921
382;166;1548;1020;1440.994;623.1583;1.3;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1321.388,-79.10914;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;11;-1262.892,339.4918;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1225.188,44.39059;Inherit;False;Property;_Tiles;Tiles;2;0;Create;True;0;0;0;False;0;False;5;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1252.49,127.5908;Inherit;False;Property;_Speed;Speed;3;0;Create;True;0;0;0;False;0;False;2;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1258.99,212.0908;Inherit;False;Property;_StartFrame;StartFrame;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation;2;-910.5863,-42.7091;Inherit;False;0;0;6;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;10;-588.1842,-54.40817;Inherit;True;Property;_LED_Example_d;LED_Example_d;0;0;Create;True;0;0;0;False;0;False;-1;56d6ce40bae0f494ea5ae815d5618ecb;114ed599d0bc8f24997357096022fc1f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-479.638,-176.6077;Inherit;False;Property;_Brightness;Brightness;4;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-266.4384,-80.40759;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;123.5001,-84.50002;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;TME/FlipBook;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;2;2;3;0
WireConnection;2;3;4;0
WireConnection;2;4;5;0
WireConnection;2;5;11;0
WireConnection;10;1;2;0
WireConnection;12;0;13;0
WireConnection;12;1;10;0
WireConnection;0;0;12;0
WireConnection;0;2;12;0
ASEEND*/
//CHKSM=C382B4061DD23DFCD62398ED8FA8BAA1E45B848C