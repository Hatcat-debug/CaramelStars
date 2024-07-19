// Upgrade NOTE: commented out 'float4 unity_DynamicLightmapST', a built-in variable
// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: commented out 'float4 unity_DynamicLightmapST', a built-in variable
// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Mobile/Glow"
{
  Properties
  {
    _Color ("Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _RimColor ("Rim Color", Color) = (1,1,1,1)
    _RimPower ("Rim Power", Range(0.5, 6)) = 3
  }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        fixed4 _Color;
        fixed4 _RimColor;
        half _RimPower;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            
            // �p����u��V�V�q�]�зǤơ^
            float3 viewDir = normalize(_WorldSpaceCameraPos - IN.worldPos);
            // �p����u��V�V�q�M���k�V�q�����n�A�o�짨��
            half rim = dot(viewDir, o.Normal);
            // ���ऺ�n�ȡA����t���w�b���V�۾��ɧ�[���G
            rim = 1 - saturate(rim);
            // �Nrim�ȴ��ɨ�_RimPower����H������w���j��
            rim = pow(rim, _RimPower);

            // �N��t���w�C��P���w�G�ײK�[��̲��C�⤤
            o.Emission = _RimColor.rgb * rim;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
