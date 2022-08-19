<script setup lang="ts">
const isMounted = ref(false);
onBeforeMount(() => {
  console.log("dom tree not done");
});
onMounted(() => {
  console.log("dom tree done");
  setTimeout(() => {
    isMounted.value = true;
    document.body.style.overflow = "auto";
  }, 3000);
});
</script>

<template>
  <div>
    <loadingring v-show="!isMounted" />
    <div>test.vue</div>
  </div>
</template>
