<template>
  <div class="add-todo">
    <input 
      v-model="newTodo" 
      @keyup.enter="submitTodo" 
      type="text" 
      placeholder="Add a new todo" 
    />
    <button @click="submitTodo">Add</button>
  </div>
</template>

<script>
import { ref } from 'vue';

export default {
  name: 'AddTodo',
  emits: ['add-todo'],
  setup(props, { emit }) {
    const newTodo = ref('');

    const submitTodo = () => {
      const text = newTodo.value.trim();
      if (text) {
        emit('add-todo', text);
        newTodo.value = '';
      }
    };

    return {
      newTodo,
      submitTodo,
    };
  },
};
</script>

<style scoped>
.add-todo {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.add-todo input {
  width: 70%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.add-todo button {
  padding: 10px 20px;
  margin-left: 10px;
  background-color: #42b983;
  border: none;
  color: white;
  cursor: pointer;
  border-radius: 4px;
}

.add-todo button:hover {
  background-color: #369870;
}
</style>
