<template>
  <div v-if="isOpen" class="image-modal-overlay" @click.self="closeModal">
    <div class="image-modal-content">
      <button class="close-button" @click="closeModal">&times;</button>
      <img :src="imageUrl" alt="Modal Image" class="modal-image" />
    </div>
  </div>
</template>

<script>
export default {
  name: 'ImageModal',
  props: {
    isOpen: {
      type: Boolean,
      required: true
    },
    imageUrl: {
      type: String,
      default: ''
    }
  },
  methods: {
    closeModal() {
      this.$emit('close'); // Emit an event to the parent to close the modal
    }
  },
  watch: {
    isOpen(newVal) {
      // Prevent scrolling the body when the modal is open
      if (newVal) {
        document.body.style.overflow = 'hidden';
      } else {
        document.body.style.overflow = '';
      }
    }
  },
  beforeUnmount() {
    // Ensure body scroll is reset if component is unmounted while modal is open
    document.body.style.overflow = '';
  }
}
</script>

<style scoped>
.image-modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7); /* Dark overlay */
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000; /* Ensure it's on top of everything */
  backdrop-filter: blur(5px); /* Optional: blur background */
}

.image-modal-content {
  background-color: white;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
  position: relative;
  max-width: 90%; /* Max width of modal */
  max-height: 90%; /* Max height of modal */
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden; /* Hide overflow of image if it's too big */
}

.modal-image {
  max-width: 100%;
  max-height: 100%;
  display: block; /* Remove extra space below image */
  object-fit: contain; /* Ensure image fits within its container */
}

.close-button {
  position: absolute;
  top: 10px;
  right: 10px;
  background: none;
  border: none;
  font-size: 2em;
  color: #aaa;
  cursor: pointer;
  padding: 5px 10px;
  border-radius: 50%;
  transition: color 0.2s ease, background-color 0.2s ease;
}

.close-button:hover {
  color: #666;
  background-color: rgba(255, 255, 255, 0.2);
}
</style>