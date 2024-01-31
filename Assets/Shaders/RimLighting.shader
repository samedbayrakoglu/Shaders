Shader "Custom/RimLighting"
{
    Properties
    {
        _rimTex ("Rim Texture", 2D) = "white" {}
        _rimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
        _rimMultiplier ("Rim Multiplier", Range(0.5, 7)) = 3
        _stripeSize ("Stripe Size", Range(1, 20)) = 10
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
     

        struct Input {
            float3 viewDir;
            float3 worldPos;
            float2 uv_rimTex;
        };
        
        float3 _rimColor;
        float _rimMultiplier;
        float _stripeSize;
        sampler2D _rimTex;

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_rimTex, IN.uv_rimTex).rgb;

            half rimDot = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            // o.Emission = _rimColor.rgb * rimDot > 0.5 ? rimDot : 0;
            // o.Emission = IN.worldPos.y > 1 ? float3(1,0,0) : 0;
            o.Emission = frac(IN.worldPos.y * (20 - _stripeSize) * 0.5) > 0.4 ? float3(1,0,0) * rimDot:float3(0,1,0) * rimDot;
        }

        
        ENDCG
    }
    FallBack "Diffuse"
}
