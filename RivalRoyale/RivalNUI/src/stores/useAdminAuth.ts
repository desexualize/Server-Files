import create from 'zustand';

interface AdminAuth {
  auth: boolean;
  setAuth: (value: boolean) => void;
}

const AdminAuthStore = (set, get) => ({
  auth: false,
  setAuth: (value) => {
    set((state) => ({ auth: value }));
  },
});

export const useAdminAuth = create<AdminAuth>(AdminAuthStore);
