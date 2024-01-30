Shader "Custom/MirrorShader"
{
    Properties
    {
        // _myColor ("Color", Color) = (1,1,1,1)
        // _myTex ("Texture", 2D) = "white" {}
        _myCube ("Cube", CUBE) = "" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        // fixed4 _myColor;
        // sampler2D _myTex;
        samplerCUBE _myCube;
        

        struct Input {
            float2 uv_myTex;
            float3 worldRefl;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            // o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange * _myColor).rgb;
            o.Albedo = texCUBE (_myCube, IN.worldRefl).rgb;
        }

        
        ENDCG
    }
    FallBack "Diffuse"
}
