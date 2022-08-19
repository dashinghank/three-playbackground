precision mediump float;

uniform vec3 uColor;
uniform sampler2D uTexture;

varying vec2 vUv;
varying vec3 vPosition;

void main()
{
    float opacity = 1.0;
    if(vPosition.y > 1.0){
      opacity = 1.0 - ((vPosition.y - 1.0) * 3.0);
    }
    
    vec4 textureColor = texture2D(uTexture, vUv);

    if(opacity >= 0.1){
      if(textureColor.a > 0.75){
        textureColor.a = opacity;
      }
    }
    else{
      textureColor.a = 0.0;
    }
    


    gl_FragColor = textureColor;
}