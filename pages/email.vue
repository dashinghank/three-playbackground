<script lang="ts" setup>
import emailjs from "@emailjs/browser";

onMounted(() => {});
function send() {
  const templateParams = {
    name: "James",
    notes: "Check this out!",
  };

  emailjs.send("<YOUR_SERVICE_ID>", "<YOUR_TEMPLATE_ID>", templateParams, "<YOUR_PUBLIC_KEY>").then(
    (response) => {
      console.log("SUCCESS!", response.status, response.text);
    },
    (err) => {
      console.log("FAILED...", err);
    }
  );
}
</script>

<template>
  <div>
    <button @click="send">ggg</button>
  </div>
</template>
