// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TME/SpeakerBoom"
{
	Properties
	{
		_Speakers_low_DefaultMaterial_AlbedoTransparency("Speakers_low_DefaultMaterial_AlbedoTransparency", 2D) = "white" {}
		_Speed("Speed", Float) = 2
		_Location("Location", Vector) = (0.5,0.5,0,0)
		_Magnitude("Magnitude", Float) = -0.1
		_Size("Size", Float) = 0.1
		_Speakers_low_DefaultMaterial_MetallicSmoothness("Speakers_low_DefaultMaterial_MetallicSmoothness", 2D) = "white" {}
		_Speakers_low_DefaultMaterial_Emissive("Speakers_low_DefaultMaterial_Emissive", 2D) = "white" {}
		_Speakers_low_DefaultMaterial_Normal("Speakers_low_DefaultMaterial_Normal", 2D) = "bump" {}
		_Color("Color", Color) = (1,0,0,1)
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

		uniform sampler2D _Speakers_low_DefaultMaterial_Normal;
		uniform float _Speed;
		uniform float _Size;
		uniform float2 _Location;
		uniform float _Magnitude;
		uniform sampler2D _Speakers_low_DefaultMaterial_AlbedoTransparency;
		uniform float4 _Color;
		uniform sampler2D _Speakers_low_DefaultMaterial_Emissive;
		uniform sampler2D _Speakers_low_DefaultMaterial_MetallicSmoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_10_0 = frac( ( _Time.y * _Speed ) );
			float2 temp_output_6_0 = ( frac( i.uv_texcoord ) - _Location );
			float smoothstepResult14 = smoothstep( ( temp_output_10_0 - _Size ) , ( temp_output_10_0 + _Size ) , distance( temp_output_6_0 , float2( 0,0 ) ));
			float2 normalizeResult17 = normalize( temp_output_6_0 );
			float2 temp_output_21_0 = ( i.uv_texcoord + ( ( ( 1.0 - smoothstepResult14 ) * smoothstepResult14 ) * ( normalizeResult17 * _Magnitude ) ) );
			o.Normal = UnpackNormal( tex2D( _Speakers_low_DefaultMaterial_Normal, temp_output_21_0 ) );
			o.Albedo = tex2D( _Speakers_low_DefaultMaterial_AlbedoTransparency, temp_output_21_0 ).rgb;
			o.Emission = ( _Color * tex2D( _Speakers_low_DefaultMaterial_Emissive, temp_output_21_0 ) ).rgb;
			float4 tex2DNode24 = tex2D( _Speakers_low_DefaultMaterial_MetallicSmoothness, temp_output_21_0 );
			o.Metallic = tex2DNode24.r;
			o.Smoothness = tex2DNode24.a;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18921
382;166;1548;1020;1699.243;1036.621;1.3;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;8;-883.1879,-753.8986;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-852.8608,-682.7995;Inherit;False;Property;_Speed;Speed;1;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1410.068,-503.6208;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;32;-1161.034,-502.5171;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-624.3381,-740.2317;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;3;-1141.5,-283.5;Inherit;False;Property;_Location;Location;2;0;Create;True;0;0;0;False;0;False;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;6;-831.5,-314.5;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;10;-400.8608,-719.7995;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-378.9857,-800.2222;Inherit;False;Property;_Size;Size;4;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-165.8608,-725.7995;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-182.3389,-634.9973;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;7;-533.5,-334.5;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;14;54.66113,-665.9973;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;324.0727,-709.38;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;17;-577.5733,-91.56616;Inherit;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-576.9583,22.80965;Inherit;False;Property;_Magnitude;Magnitude;3;0;Create;True;0;0;0;False;0;False;-0.1;-0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-339.7661,-63.90442;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;509.6611,-658.9973;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;960.4995,-794.0383;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;841.3558,-427.4467;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;1333.204,-500.7628;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;27;1997.619,-235.9078;Inherit;False;Property;_Color;Color;8;0;Create;True;0;0;0;False;0;False;1,0,0,1;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;1863.191,-37.66499;Inherit;True;Property;_Speakers_low_DefaultMaterial_Emissive;Speakers_low_DefaultMaterial_Emissive;6;0;Create;True;0;0;0;False;0;False;-1;e6a5e34decfa5be45918d27f2fa64655;e6a5e34decfa5be45918d27f2fa64655;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;28;1903.954,-443.48;Inherit;True;Property;_Speakers_low_DefaultMaterial_Normal;Speakers_low_DefaultMaterial_Normal;7;0;Create;True;0;0;0;False;0;False;-1;c211840540e9d314291cc62144070368;c211840540e9d314291cc62144070368;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;1810.521,-856.0912;Inherit;True;Property;_Speakers_low_DefaultMaterial_AlbedoTransparency;Speakers_low_DefaultMaterial_AlbedoTransparency;0;0;Create;True;0;0;0;False;0;False;-1;f253dda3ae314084784e5c9d5c34304a;f253dda3ae314084784e5c9d5c34304a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;2256.457,-122.6994;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;24;1810.184,-654.991;Inherit;True;Property;_Speakers_low_DefaultMaterial_MetallicSmoothness;Speakers_low_DefaultMaterial_MetallicSmoothness;5;0;Create;True;0;0;0;False;0;False;-1;6bb669b4f1cafd74fa1fdcccd13a466c;6bb669b4f1cafd74fa1fdcccd13a466c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2620.348,-633.017;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;TME/SpeakerBoom;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;2;0
WireConnection;9;0;8;0
WireConnection;9;1;11;0
WireConnection;6;0;32;0
WireConnection;6;1;3;0
WireConnection;10;0;9;0
WireConnection;12;0;10;0
WireConnection;12;1;4;0
WireConnection;13;0;10;0
WireConnection;13;1;4;0
WireConnection;7;0;6;0
WireConnection;14;0;7;0
WireConnection;14;1;13;0
WireConnection;14;2;12;0
WireConnection;15;0;14;0
WireConnection;17;0;6;0
WireConnection;18;0;17;0
WireConnection;18;1;5;0
WireConnection;16;0;15;0
WireConnection;16;1;14;0
WireConnection;19;0;16;0
WireConnection;19;1;18;0
WireConnection;21;0;20;0
WireConnection;21;1;19;0
WireConnection;25;1;21;0
WireConnection;28;1;21;0
WireConnection;1;1;21;0
WireConnection;26;0;27;0
WireConnection;26;1;25;0
WireConnection;24;1;21;0
WireConnection;0;0;1;0
WireConnection;0;1;28;0
WireConnection;0;2;26;0
WireConnection;0;3;24;1
WireConnection;0;4;24;4
ASEEND*/
//CHKSM=7FFFD01A5693409665E04B9A91A1C127FB51BB5E