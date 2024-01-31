Shader "Custom/Metallic"
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
            float2 uv_myNormal;
            float3 worldRefl; INTERNAL_DATA
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = texCUBE(_myCube, WorldReflectionVector (IN, o.Normal)).rgb;
            o.Normal = UnpackNormal(tex2D(_myNormal, IN.uv_myNormal)) * 0.3;
        }

        
        ENDCG
    }
    FallBack "Diffuse"
}
