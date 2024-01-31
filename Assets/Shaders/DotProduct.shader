Shader "Custom/DotProductShader"
{
    Properties
    {
        _myNormal ("Normal Texture", 2D) = "bump" {}
        _myCube ("Cube Map", CUBE) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myNormal;
        samplerCUBE _myCube;
     

        struct Input {
            float3 viewDir;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            half dotp = dot(IN.viewDir, o.Normal);
            o.Albedo = float3(1 -dotp, 1, 1);
        }

        
        ENDCG
    }
    FallBack "Diffuse"
}
