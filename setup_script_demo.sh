#!/bin/bash

# Variables
PROJECT_NAME="vue-todo-app"

# Install dependencies
echo "Installing dependencies..."
npm install

# Create components directory
mkdir -p src/components

# Create AddTodo.vue
cat > src/components/AddTodo.vue <<EOL
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
EOL

# Create TodoItem.vue
cat > src/components/TodoItem.vue <<EOL
<template>
  <div class="todo-item">
    <input 
      type="checkbox" 
      :checked="todo.completed" 
      @change="toggleTodo" 
    />
    <span :class="{ completed: todo.completed }">{{ todo.text }}</span>
    <button @click="deleteTodo">Delete</button>
  </div>
</template>

<script>
export default {
  name: 'TodoItem',
  props: {
    todo: {
      type: Object,
      required: true,
    },
  },
  emits: ['delete-todo', 'toggle-todo'],
  methods: {
    deleteTodo() {
      this.$emit('delete-todo', this.todo.id); // Corrected line
    },
    toggleTodo() {
      this.$emit('toggle-todo', this.todo.id); // Corrected line
    },
  },
};
</script>

<style scoped>
.todo-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px;
  border-bottom: 1px solid #ddd;
}

.todo-item span {
  flex-grow: 1;
  margin-left: 10px;
  text-align: left;
}

.todo-item span.completed {
  text-decoration: line-through;
  color: #888;
}

.todo-item button {
  background-color: #ff4d4d;
  border: none;
  color: white;
  padding: 5px 10px;
  cursor: pointer;
}

.todo-item button:hover {
  background-color: #ff1a1a;
}
</style>
EOL

# Create TodoList.vue
cat > src/components/TodoList.vue <<EOL
<template>
  <div class="todo-list">
    <TodoItem 
      v-for="todo in todos" 
      :key="todo.id" 
      :todo="todo" 
      :isEditing="editingTodoId === todo.id"
      @delete-todo="$emit('delete-todo', \$event)" 
      @toggle-todo="$emit('toggle-todo', \$event)" 
      @enable-edit="enableEdit"
      @update-todo="$emit('update-todo', \$event)"
      @cancel-edit="cancelEdit"
    />
    <p v-if="todos.length === 0">No todos yet!</p>
  </div>
</template>

<script>
import TodoItem from './TodoItem.vue';

export default {
  name: 'TodoList',
  components: {
    TodoItem,
  },
  props: {
    todos: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      editingTodoId: null, // Track which todo is being edited
    };
  },
  methods: {
    enableEdit(id) {
      this.editingTodoId = id;
    },
    cancelEdit() {
      this.editingTodoId = null;
    },
  },
};
</script>

<style scoped>
.todo-list {
  margin-top: 20px;
}
</style>
EOL

# Overwrite App.vue
cat > src/App.vue <<EOL
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
EOL

# Inform the user
echo "Setup complete! To run the project, execute the following commands:"
echo "npm run dev"
