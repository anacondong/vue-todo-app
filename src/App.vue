<template>
  <div class="app-container">
    <h1>Vue.js Todo App</h1>
    <AddTodo @add-todo="addTodo" />
    <TodoList 
      :todos="todos" 
      @delete-todo="deleteTodo" 
      @toggle-todo="toggleTodo"
      @update-todo="updateTodo"
    />
  </div>
</template>

<script>
import { ref } from 'vue';
import TodoList from './components/TodoList.vue';
import AddTodo from './components/AddTodo.vue';

export default {
  name: 'App',
  components: {
    TodoList,
    AddTodo,
  },
  setup() {
    const todos = ref([
      { id: 1, text: 'Learn Vue.js', completed: false },
      { id: 2, text: 'Build a Todo App', completed: false },
    ]);

    const addTodo = (text) => {
      const newTodo = {
        id: Date.now(),
        text,
        completed: false,
      };
      todos.value.push(newTodo);
    };

    const deleteTodo = (id) => {
      todos.value = todos.value.filter(todo => todo.id !== id);
    };

    const toggleTodo = (id) => {
      const todo = todos.value.find(todo => todo.id === id);
      if (todo) {
        todo.completed = !todo.completed;
      }
    };

    const updateTodo = ({ id, text }) => {
      const todo = todos.value.find(todo => todo.id === id);
      if (todo) {
        todo.text = text;
      }
    };

    return {
      todos,
      addTodo,
      deleteTodo,
      toggleTodo,
      updateTodo,
    };
  },
};
</script>

<style scoped>
.app-container {
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
  text-align: center;
}

h1 {
  color: #42b983;
  margin-bottom: 20px;
}
</style>
