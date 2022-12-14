<script setup lang="ts">
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { CustomEase } from "gsap/CustomEase";
import * as THREE from "three";
import * as CANNON from "cannon-es";
import { WaitMilliseconds } from "flag-waiter";
gsap.registerPlugin(ScrollTrigger, CustomEase);

class Member {
  iconUrls: string[] = [];
  iconTextures: THREE.Texture[] = [];
  emojiTextures: THREE.Texture[] = [];
  name: string = "";
  companyPosition: string = "";
  emojiUrls: string[] = [];
  addIconUrls(urls: string[]) {
    this.iconUrls = urls;
    for (let url of urls) {
      this.iconTextures.push(textureLoader.load(url));
    }
  }
  addEmojiUrls(urls: string[]) {
    this.emojiUrls = urls;
    for (let url of urls) {
      this.emojiTextures.push(textureLoader.load(url));
    }
  }
  addName(name: string) {
    this.name = name;
  }
  addCompanyPosition(companyPosition: string) {
    this.companyPosition = companyPosition;
  }
  getIconTextures = () => this.iconTextures;
}

//THREE Canvas、scene、clock
const myCanvas = ref();
const scene = new THREE.Scene(); //建立場景
const clock = new THREE.Clock();

const sphereBody = ref();

//物理規則世界
const world = ref();
const worldNog = ref();
const worldObjectsToUpdate: any = ref([]);

const objectsToUpdate: any = ref([]);

// Member Icon img srcs

const memberBtnDatas = ref([
  {
    name: "Kevin",
    companyPosition: "CO_founder & CTO",
    memberIconImgSrc: "member/k1.png",
    memberEmojiImgSrcs: ["member/emojis/k1.png", "member/emojis/k2.png", "member/emojis/k3.png"],
  },
  {
    name: "Pon",
    companyPosition: "CO_founder & CBO",
    memberIconImgSrc: "member/p1.png",
    memberEmojiImgSrcs: ["member/emojis/p1.png", "member/emojis/p2.png", "member/emojis/p3.png"],
  },
  {
    name: "Hank",
    companyPosition: "Frond-end developer",
    memberIconImgSrc: "member/h2.png",
    memberEmojiImgSrcs: ["member/emojis/h1.png", "member/emojis/h2.png", "member/emojis/h3.png"],
  },
  {
    name: "Rinran",
    companyPosition: "Visual designer",
    memberIconImgSrc: "member/r1.png",
    memberEmojiImgSrcs: ["member/emojis/r1.png", "member/emojis/r2.svg", "member/emojis/r3.svg"],
  },
  {
    name: "MA",
    companyPosition: "Visual designer",
    memberIconImgSrc: "member/m1.png",
    memberEmojiImgSrcs: ["member/emojis/m1.png", "member/emojis/m2.png", "member/emojis/m3.png"],
  },
  {
    name: "Gp",
    companyPosition: "Sales",
    memberIconImgSrc: "member/g1.png",
    memberEmojiImgSrcs: ["member/emojis/g1.png", "member/emojis/g2.png", "member/emojis/g3.png"],
  },
  {
    name: "Vivi",
    companyPosition: "Sales",
    memberIconImgSrc: "member/vivi01.png",
    memberEmojiImgSrcs: ["member/emojis/vivi01.png", "member/emojis/vivi02.png", "member/emojis/vivi03.png"],
  },
]);

//Icons 為所有成員
var members = ref({});
var currentMemberIndex = ref(0);

world.value = new CANNON.World({
  gravity: new CANNON.Vec3(0, 400, 0), // m/s²
});
worldNog.value = new CANNON.World({
  gravity: new CANNON.Vec3(0, 0, 0), // m/s²
});
world.value.broadphase = new CANNON.SAPBroadphase(world.value);
worldNog.value.broadphase = new CANNON.SAPBroadphase(worldNog.value);

const textureLoader = new THREE.TextureLoader();
// const textures = ref([]);

onMounted(async () => {
  members.value["kevin"] = new Member();
  members.value["kevin"].addIconUrls(["/member/k1.png", "/member/k2.png", "/member/k3.png"]);
  members.value["pon"] = new Member();
  members.value["pon"].addIconUrls(["/member/p1.png", "/member/p2.png", "/member/p3.png"]);
  members.value["hank"] = new Member();
  members.value["hank"].addIconUrls(["/member/h1.png", "/member/h2.png", "/member/h3.png"]);
  members.value["rinran"] = new Member();
  members.value["rinran"].addIconUrls(["/member/r1.png", "/member/r2.png", "/member/r3.png"]);
  members.value["ma"] = new Member();
  members.value["ma"].addIconUrls(["/member/m1.png", "/member/m2.png", "/member/m3.png"]);
  members.value["gp"] = new Member();
  members.value["gp"].addIconUrls(["/member/g1.png", "/member/g2.png", "/member/g3.png"]);
  members.value["vi"] = new Member();
  members.value["vi"].addIconUrls(["/member/vivi01.png", "/member/vivi02.png", "/member/vivi03.png"]);

  try {
    const sphereGeometry = new THREE.PlaneGeometry(85, 100, 32, 32);

    initThree();

    let positionX = Math.random() * 600 - 300;

    createWorldObject(50, sphereGeometry, new THREE.Vector3(positionX, -150, -400), { transparent: true, map: members.value["kevin"].getIconTextures()[Math.floor(Math.random() * 3)] });
    await WaitMilliseconds(300);
    createWorldObject(50, sphereGeometry, new THREE.Vector3(positionX + 50, -220, -400), { transparent: true, map: members.value["kevin"].getIconTextures()[Math.floor(Math.random() * 3)] });
    await WaitMilliseconds(300);
    createWorldObject(50, sphereGeometry, new THREE.Vector3(positionX + 100, -350, -400), { transparent: true, map: members.value["kevin"].getIconTextures()[Math.floor(Math.random() * 3)] });
    await WaitMilliseconds(300);
    createWorldObject(50, sphereGeometry, new THREE.Vector3(positionX - 200, -150, -400), { transparent: true, map: members.value["kevin"].getIconTextures()[Math.floor(Math.random() * 3)] });
    await WaitMilliseconds(300);
    createWorldObject(50, sphereGeometry, new THREE.Vector3(positionX - 400, -150, -400), { transparent: true, map: members.value["kevin"].getIconTextures()[Math.floor(Math.random() * 3)] });
    await WaitMilliseconds(300);
    createWorldObject(50, sphereGeometry, new THREE.Vector3(positionX - 300, -350, -400), { transparent: true, map: members.value["kevin"].getIconTextures()[Math.floor(Math.random() * 3)] });
  } catch (error) {
    console.log("error:", error);
  }
});

// friction 摩擦力 restitution 彈性
const defaultMaterial = new CANNON.Material("default");
const defaultContactMaterial = new CANNON.ContactMaterial(defaultMaterial, defaultMaterial, {
  friction: 100,
  restitution: 0.5,
});
// friction 摩擦力 restitution 彈性

//cannon floor

const createWorldObject = async (radius: number, geometry, position: THREE.Vector3, settings: any) => {
  // Three.js mesh
  const material = new THREE.MeshBasicMaterial(settings);
  const mesh = new THREE.Mesh(geometry, material);

  mesh.castShadow = true;
  scene.add(mesh);
  mesh.position.copy(position);

  // Cannon body
  world.value.addContactMaterial(defaultContactMaterial);
  const shape = new CANNON.Sphere(radius);
  const body = new CANNON.Body({
    mass: 1,
    shape,
    material: defaultMaterial,
  });
  worldObjectsToUpdate.value.push({
    mesh,
    body,
  });
  // @ts-ignore
  body.position.copy(position);
  world.value.addBody(body);
};

const createObject = async (geometry, position: THREE.Vector3, settings: any) => {
  // Three.js mesh
  const material = new THREE.MeshBasicMaterial(settings);
  const mesh = new THREE.Mesh(geometry, material);
  mesh.castShadow = true;

  scene.add(mesh);
  mesh.position.copy(position);
  objectsToUpdate.value.push({
    mesh,
  });
  // @ts-ignore
};

function initThree() {
  // Sizes
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  };
  console.log(sizes);
  // Camera
  // const camera = new THREE.PerspectiveCamera(75, sizes.width / sizes.height, 0.1, 100);
  const camera = new THREE.OrthographicCamera(sizes.width / -2, sizes.width / 2, sizes.height / 2, sizes.height / -2, 1, 1000);
  camera.position.set(0, 0, 150);

  scene.add(camera);

  // Scene

  // const raycaster = new THREE.Raycaster();
  // const pointer = new THREE.Vector2();
  // var intersectedObjects = objectsToUpdate.value[0].mesh;

  // const btnUpMemberTexture = textureLoader.load("/member/btn.png");
  // const btnDownMemberTexture = textureLoader.load("/member/btnDown.png");

  // const onMouseClick = (event) => {
  //   raycaster.setFromCamera(pointer, camera);
  //   var isIntersected = raycaster.intersectObject(intersectedObjects);
  //   if (isIntersected.length > 0) {
  //     console.log("Mesh clicked!");
  //     console.log(members.value, currentMemberIndex.value);

  //     if (currentMemberIndex.value < 6) {
  //       currentMemberIndex.value++;
  //     } else {
  //       currentMemberIndex.value = 0;
  //     }

  //     for (let i = 0; i < 6; i++) {
  //       worldObjectsToUpdate.value[i].body.applyForce(new CANNON.Vec3(Math.floor(Math.random() * 20000) - 10000, -(Math.random() * 12500 + 7500), 0), new CANNON.Vec3(0, 0, 0));

  //       worldObjectsToUpdate.value[i].mesh.material.map = members.value[Object.keys(members.value)[currentMemberIndex.value]].getIconTextures()[Math.floor(Math.random() * 3)];
  //     }
  //     objectsToUpdate.value[0].mesh.material.map = btnDownMemberTexture;
  //   }
  // };

  // const onMouseUp = (event) => {
  //   console.log("up");
  //   objectsToUpdate.value[0].mesh.material.map = btnUpMemberTexture;
  // };
  // const onMouseMove = (event) => {
  //   pointer.x = (event.clientX / window.innerWidth) * 2 - 1;
  //   pointer.y = -(event.clientY / window.innerHeight) * 2 + 1;
  // };

  // window.addEventListener("mousedown", onMouseClick, false);
  // window.addEventListener("mouseup", onMouseUp, false);
  // window.addEventListener("mousemove", onMouseMove, false);

  /**
   * Light
   */
  const directionLight = new THREE.DirectionalLight();
  directionLight.castShadow = true;
  directionLight.position.set(5, 5, 6);
  const ambientLight = new THREE.AmbientLight(new THREE.Color("#ffffff"), 0.3);
  scene.add(ambientLight, directionLight);

  const directionLightHelper = new THREE.DirectionalLightHelper(directionLight, 2);
  directionLightHelper.visible = false;
  scene.add(directionLightHelper);

  // Renderer
  const renderer = new THREE.WebGLRenderer({
    canvas: myCanvas.value,
    antialias: true,
  });

  renderer.setSize(sizes.width, sizes.height);

  // Animate
  const tick = () => {
    world.value.fixedStep();
    worldObjectsToUpdate.value.forEach((d) => {
      d.mesh.position.x = d.body.position.x;
      d.mesh.position.y = d.body.position.y;
      d.mesh.position.z = d.body.position.z;
    });

    // Render
    renderer.render(scene, camera);
  };
  var aspect = sizes.width / sizes.height;

  //cannon floor
  const floorShape = new CANNON.Plane();

  const topFloorBody = new CANNON.Body();
  const leftFloorBody = new CANNON.Body();
  const rightFloorBody = new CANNON.Body();
  const bottomFloorBody = new CANNON.Body();

  topFloorBody.mass = 0;
  topFloorBody.addShape(floorShape);
  topFloorBody.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), Math.PI / 2);
  topFloorBody.material = defaultMaterial;
  topFloorBody.position.y = 480;

  leftFloorBody.position.x = -850 * (aspect / 1.7);
  leftFloorBody.mass = 0;
  leftFloorBody.addShape(floorShape);
  leftFloorBody.quaternion.setFromAxisAngle(new CANNON.Vec3(0, 1, 0), Math.PI / 2);
  leftFloorBody.material = defaultMaterial;

  rightFloorBody.position.x = 850 * (aspect / 1.7);
  rightFloorBody.mass = 0;
  rightFloorBody.addShape(floorShape);
  rightFloorBody.quaternion.setFromAxisAngle(new CANNON.Vec3(0, 1, 0), -Math.PI / 2);
  rightFloorBody.material = defaultMaterial;

  bottomFloorBody.position.y = -480;
  bottomFloorBody.mass = 0;
  bottomFloorBody.addShape(floorShape);
  bottomFloorBody.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), -Math.PI / 2);
  bottomFloorBody.material = defaultMaterial;

  world.value.addBody(topFloorBody);
  world.value.addBody(leftFloorBody);
  world.value.addBody(rightFloorBody);
  world.value.addBody(bottomFloorBody);
  //cannon floor

  window.addEventListener("resize", () => {
    console.log("resize", -1530 / aspect);

    sizes.width = window.innerWidth;
    sizes.height = window.innerHeight;
    aspect = sizes.width / sizes.height;

    leftFloorBody.position.x = -850 * (aspect / 1.7);
    rightFloorBody.position.x = 850 * (aspect / 1.7);

    //camera
    camera.left = sizes.width / -2;
    camera.right = sizes.width / 2;
    camera.top = sizes.height / 2;
    camera.bottom = -sizes.height / 2;
    camera.updateProjectionMatrix();

    // Update renderer
    renderer.setSize(sizes.width, sizes.height);
  });
  renderer.setAnimationLoop(tick);
}

const onClickTextBtn = () => {
  console.log("onClick");
  if (currentMemberIndex.value < 6) {
    currentMemberIndex.value++;
  } else {
    currentMemberIndex.value = 0;
  }

  for (let i = 0; i < 6; i++) {
    worldObjectsToUpdate.value[i].body.applyForce(new CANNON.Vec3(Math.floor(Math.random() * 20000) - 10000, -(Math.random() * 12500 + 7500), 0), new CANNON.Vec3(0, 0, 0));

    worldObjectsToUpdate.value[i].mesh.material.map = members.value[Object.keys(members.value)[currentMemberIndex.value]].getIconTextures()[Math.floor(Math.random() * 3)];
  }
};
</script>

<template>
  <div class="relative w-full flex justify-center">
    <canvas ref="myCanvas"> </canvas>
    <!-- <div class="absolute top-10 text-white text-5xl z-[1000]">wqdqwdqwqwdqdqwd</div> -->
    <div class="absolute bottom-1/4 tracking-[0.095em] font-black" style="font-family: arial-black">
      <p class="w-fit mx-auto text-4xl text-white">MEET OUR TEAM</p>
      <button class="mt-5 py-8 px-16 w-[549px] h-[152px] text-[#292F33] text-5xl z-[1000] border-white border-2 rounded-full grid grid-cols-12 bg-white justify-center items-center" @click="onClickTextBtn">
        <div class="w-16 h-16 my-auto col-start-2 col-span-3">
          <img class="w-full h-full" :src="memberBtnDatas[currentMemberIndex].memberIconImgSrc" />
        </div>
        <div class="text-start col-span-8">
          <div class="flex items-end gap-5">
            <p class="text-4xl leading-[1.75rem]">{{ memberBtnDatas[currentMemberIndex].name }}</p>
            <div class="flex gap-2.5 items-end">
              <div class="w-6 h-6" v-for="n in 3">
                <img class="w-full h-full" :src="memberBtnDatas[currentMemberIndex].memberEmojiImgSrcs[n - 1]" />
              </div>
            </div>
          </div>
          <p class="text-2xl">{{ memberBtnDatas[currentMemberIndex].companyPosition }}</p>
        </div>
      </button>
    </div>
  </div>
</template>
<style></style>
