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
