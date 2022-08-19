<script setup lang="ts">
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { CustomEase } from "gsap/CustomEase";
import * as THREE from "three";
import particleFragment from "assets/shaders/bubble/bubbleFragment.glsl?raw";
import particleVertex from "assets/shaders/bubble/bubbleVertex.glsl?raw";
gsap.registerPlugin(ScrollTrigger, CustomEase);

const myCanvas = ref();
onMounted(() => {
  emojiBackground();
});

function emojiBackground() {
  // Scene
  const scene = new THREE.Scene(); //建立場景

  const textureLoader = new THREE.TextureLoader();
  const handShakeTexture = textureLoader.load("/emoji-handshake.png");
  // Object
  const geometry = new THREE.PlaneGeometry(0.173, 0.1);
  const material = new THREE.RawShaderMaterial({
    vertexShader: particleVertex,
    fragmentShader: particleFragment,
    transparent: true,
    uniforms: {
      uTexture: { value: handShakeTexture },
    },
  });

  var arr = [];
  for (let i = 0; i < 10; i++) {
    const mesh = new THREE.Mesh(geometry, material);

    mesh.position.y = -10;

    arr.push(mesh);
    scene.add(mesh);
  }

  for (let i = 0; i < arr.length; i++) {
    gsap.fromTo(
      arr[i].position,
      {
        x: "random(-1.4,1.4)",
        y: "random(-3,-2.2)",
        z: 5,
      },
      {
        delay: "random(0,5)",
        x: "random(-2.8,2.8)",
        z: 5,
        y: 2,
        duration: "random(2,4)",
        repeat: -1,
        repeatRefresh: true,
        ease: "Power.easeInOut",
      }
    );
  }

  // Sizes
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  };

  // Camera
  const camera = new THREE.PerspectiveCamera(120, sizes.width / sizes.height, 0.1, 1);

  camera.position.z = 6;
  scene.add(camera);

  // Renderer
  const renderer = new THREE.WebGLRenderer({
    canvas: myCanvas.value,
    antialias: true,
  });
  renderer.setSize(sizes.width, sizes.height);

  // Animate
  const tick = () => {
    // Render
    renderer.render(scene, camera);
  };

  window.addEventListener("resize", () => {
    //Controls
    // Update sizes
    // orbitControl.update();
    sizes.width = window.innerWidth;
    sizes.height = window.innerHeight;
    // Update renderer
    renderer.setSize(sizes.width, sizes.height);
    // Update camera
    camera.aspect = sizes.width / sizes.height; //這個值是預防圖像扭曲
    camera.updateProjectionMatrix(); //然後執行這個來更新camera內部數值
  });
  renderer.setAnimationLoop(tick);
}
</script>

<template>
  <canvas ref="myCanvas"></canvas>
</template>
<style></style>
