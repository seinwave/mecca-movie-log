import { Controller } from '@hotwired/stimulus';

export class RatingForm extends Controller {
  static targets = ['new', 'existing'];

  toggle_movie_form(e) {
    e.preventDefault();
    this.existingTarget.classList.toggle('hidden');
    this.newTarget.classList.toggle('hidden');
  }
}
