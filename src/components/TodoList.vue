<template>
  <div class="todo-list">
    <TodoItem 
      v-for="todo in todos" 
      :key="todo.id" 
      :todo="todo" 
      :isEditing="editingTodoId === todo.id"
      @delete-todo="('delete-todo', $event)" 
      @toggle-todo="('toggle-todo', $event)" 
      @enable-edit="enableEdit"
      @update-todo="('update-todo', $event)"
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
