import { Controller } from '@hotwired/stimulus';

export class RatingForm extends Controller {
  static targets = ['new', 'existing', 'toggleButton'];

  toggle_movie_form(e) {
    e.preventDefault();
    this.toggleButtonText();
    this.existingTarget.classList.toggle('hidden');
    this.newTarget.classList.toggle('hidden');
  }

  toggleButtonText() {
    const button = this.toggleButtonTarget;
    if (button.textContent === 'Add a new movie') {
      button.textContent = 'Rate an existing movie';
    } else {
      button.textContent = 'Add a new movie';
    }
  }
}
