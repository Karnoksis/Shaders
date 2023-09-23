Shader "Unlit/ShaderUnlit"
{
    Properties
    {
        _ColorA("Color A", Color) = (1,0,0,0)
        _ColorB("Color B", Color) = (0,1,0,0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert //Сам минимальный вертексный шейдер в UnityCG.cginc
            #pragma fragment frag


            #include "UnityCG.cginc"

            fixed4 _ColorA;
             fixed4 _ColorB;

            struct v2f 
            {
                float4 vertex: SV_POSITION;
                float4 position: TEXCOORD1;
                half2 uv: TEXCOORD0;
            };
            /*
            struct appdata_base
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            */
            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); //Тут преобразование из POSITION в SV_POSITION на выход
                o.position = v.vertex; //Тут преборазование из POSITION в TEXCOORD1
                o.uv = v.texcoord; //тут обычная передача данных
                return o;
            }

            fixed4 frag (v2f i) : SV_Target //тут v2f_img - это просто структура, которая определена заранее в UnityCG.cginc
            {
                float delta = i.uv.x;
                fixed4 _ColorD = lerp(_ColorA,_ColorB,delta);
                return _ColorD;
            }
            ENDCG
        }
    }
}
