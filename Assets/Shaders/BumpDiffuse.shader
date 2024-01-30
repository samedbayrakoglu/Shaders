Shader "Custom/BumpDiffuse" {
	
	Properties {
	     _myDiffuseTex ("Diffuse Texture", 2D) = "white" {}
	     _myBumpTex ("Bump Texture", 2D) = "bump" {}
		 _mySlider ("Bump Amount", Range(0, 10)) = 1
		 _myScaleSlider ("Bump Scale", Range(0.5, 2)) = 1 // to change the scale of diffuse and bump texture
		 _myBright ("Brightness", Range(0,10)) = 1
		 _myCubeMap ("Cube Map", CUBE) = "white" {}
	 }
	
	SubShader {
		
		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myDiffuseTex;
			sampler2D _myBumpTex;
			half _mySlider;
			half _myScaleSlider;
			half _myBright;
			samplerCUBE _myCubeMap;
 
			struct Input {
				float2 uv_myDiffuseTex;
				float2 uv_myBumpTex;
				float3 worldRefl; INTERNAL_DATA
			};

			
			void surf (Input IN, inout SurfaceOutput o){
			    o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex * _myScaleSlider).rgb;
			    o.Normal = UnpackNormal(tex2D(_myBumpTex, IN.uv_myBumpTex  * _myScaleSlider)) * _myBright;
				o.Normal *= float3(_mySlider, _mySlider, 1);
				o.Emission = texCUBE(_myCubeMap, WorldReflectionVector (IN, o.Normal)).rgb;
			}
		
		ENDCG
	}
	
	FallBack "Diffuse"
}