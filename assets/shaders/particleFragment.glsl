precision mediump float;

uniform vec3 uColor;
uniform sampler2D uTexture;

varying vec2 vUv;
varying vec3 vPosition;

void main()
{
    float opacity = (vPosition.z - 4.9)* 5.0;
    if(opacity > 1.0){
      opacity = 1.0;
    } 
    vec4 textureColor = texture2D(uTexture, vUv);
    if(textureColor.a > 0.75){
      textureColor.a = opacity;
    }
    


    gl_FragColor = textureColor;
}